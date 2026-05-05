codeunit 50933 "Perf Sample Dictionary Good"
{
    procedure MarkSeenCustomers(var SalesLine: Record "Sales Line")
    var
        SeenCustomerNos: Dictionary of [Code[20], Boolean];
    begin
        if SalesLine.FindSet() then
            repeat
                if not SeenCustomerNos.ContainsKey(SalesLine."Sell-to Customer No.") then
                    SeenCustomerNos.Add(SalesLine."Sell-to Customer No.", true);
            until SalesLine.Next() = 0;
    end;
}
