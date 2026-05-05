codeunit 50830 "Upgrade Sample Trigger Good"
{
    Subtype = Upgrade;

    trigger OnValidateUpgradePerCompany()
    var
        UpgradeTag: Codeunit "Upgrade Tag";
    begin
        // Required for regulatory data validation before this release can run.
        if UpgradeTag.HasUpgradeTag(ValidationTag()) then
            exit;

        ValidateAllCustomers();
        UpgradeTag.SetUpgradeTag(ValidationTag());
    end;

    local procedure ValidateAllCustomers()
    begin
    end;

    local procedure ValidationTag(): Code[250]
    begin
        exit('MS-000010-ValidateCustomers-20260501');
    end;
}
