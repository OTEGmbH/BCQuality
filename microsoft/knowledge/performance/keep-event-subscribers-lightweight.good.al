codeunit 50930 "Perf Sample Subscriber Good"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure OnAfterValidateSalesLineNo(var Rec: Record "Sales Line")
    var
        Item: Record Item;
    begin
        if Rec.Type <> Rec.Type::Item then
            exit;

        Item.SetLoadFields("Costing Method");
        if Item.Get(Rec."No.") then
            if Item."Costing Method" = Item."Costing Method"::Specific then
                UpdateSpecificCostingState(Rec);
    end;

    local procedure UpdateSpecificCostingState(var SalesLine: Record "Sales Line")
    begin
    end;
}
