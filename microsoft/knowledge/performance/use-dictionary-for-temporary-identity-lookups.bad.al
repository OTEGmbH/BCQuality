codeunit 50934 "Perf Sample TempLookup Bad"
{
    procedure MarkSeenCustomers(var SalesLine: Record "Sales Line")
    var
        TempCustomer: Record Customer temporary;
    begin
        if SalesLine.FindSet() then
            repeat
                if not TempCustomer.Get(SalesLine."Sell-to Customer No.") then begin
                    TempCustomer.Init();
                    TempCustomer."No." := SalesLine."Sell-to Customer No.";
                    TempCustomer.Insert();
                end;
            until SalesLine.Next() = 0;
    end;
}
