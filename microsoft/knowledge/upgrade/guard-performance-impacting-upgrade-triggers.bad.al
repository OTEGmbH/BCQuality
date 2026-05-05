codeunit 50831 "Upgrade Sample Trigger Bad"
{
    Subtype = Upgrade;

    trigger OnValidateUpgradePerCompany()
    begin
        ValidateAllCustomers();
    end;

    local procedure ValidateAllCustomers()
    begin
    end;
}
