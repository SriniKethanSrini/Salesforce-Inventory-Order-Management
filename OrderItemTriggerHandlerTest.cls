@IsTest
private class OrderItemTriggerHandlerTest {

    @IsTest
    static void testInventoryReduction() {

        // Create Product
        Product2 product = new Product2(
            Name = 'Test Laptop',
            IsActive = true
        );

        insert product;

        // Create Inventory
        Inventory__c inventory = new Inventory__c(
            Name = 'Test Laptop Inventory',
            product_ecommerce__c = product.Id,
            Available_Quantity__c = 50
        );

        insert inventory;

        // Create Order
        // Add your required Order fields here
        Orders__c orderRecord = new Orders__c(
            Name = 'Test Order'
        );

        insert orderRecord;

        // Create Order Item
        Order_Item__c orderItem = new Order_Item__c(
            product_ecommerce__c = product.Id,
            Orders__c = orderRecord.Id,
            Quantity__c = 3,
            Unit_Price__c = 50000
        );

        Test.startTest();

        insert orderItem;

        Test.stopTest();

        // Get updated inventory
        Inventory__c updatedInventory = [
            SELECT Id, Available_Quantity__c
            FROM Inventory__c
            WHERE Id = :inventory.Id
        ];

        // Verify stock reduction
        System.assertEquals(
            47,
            updatedInventory.Available_Quantity__c
        );
    }
}
