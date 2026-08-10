trigger OrderItemTrigger on Order_Item__c (before insert) {

    OrderItemTriggerHandler.validateAndUpdateInventory(Trigger.new);

}
