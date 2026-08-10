public class OrderItemTriggerHandler {

    public static void validateAndUpdateInventory(
        List<Order_Item__c> orderItems
    ) {

        // Collect Product IDs
        Set<Id> productIds = new Set<Id>();

        for (Order_Item__c item : orderItems) {

            if (item.product_ecommerce__c != null) {
                productIds.add(item.product_ecommerce__c);
            }
        }

        // Stop if no products are selected
        if (productIds.isEmpty()) {
            return;
        }

        // Query Inventory records
        Map<Id, Inventory__c> inventoryMap =
            new Map<Id, Inventory__c>();

        for (Inventory__c inv : [
            SELECT Id,
                   product_ecommerce__c,
                   Available_Quantity__c
            FROM Inventory__c
            WHERE product_ecommerce__c IN :productIds
            FOR UPDATE
        ]) {

            inventoryMap.put(
                inv.product_ecommerce__c,
                inv
            );
        }

        // Validate Order Items
        for (Order_Item__c item : orderItems) {

            // Product validation
            if (item.product_ecommerce__c == null) {

                item.addError(
                    'Please select a Product.'
                );

                continue;
            }

            // Find related Inventory
            Inventory__c inventory =
                inventoryMap.get(
                    item.product_ecommerce__c
                );

            // Inventory validation
            if (inventory == null) {

                item.addError(
                    'No inventory record found for this product.'
                );

                continue;
            }

            // Quantity validation
            if (item.Quantity__c == null ||
                item.Quantity__c <= 0) {

                item.addError(
                    'Quantity must be greater than zero.'
                );

                continue;
            }

            // Check available stock
            if (inventory.Available_Quantity__c <
                item.Quantity__c) {

                item.addError(
                    'Insufficient stock. Available quantity: ' +
                    inventory.Available_Quantity__c
                );

            } else {

                // Reduce available inventory
                inventory.Available_Quantity__c =
                    inventory.Available_Quantity__c -
                    item.Quantity__c;
            }
        }

        // Update Inventory
        if (!inventoryMap.isEmpty()) {

            update inventoryMap.values();

        }
    }
}
