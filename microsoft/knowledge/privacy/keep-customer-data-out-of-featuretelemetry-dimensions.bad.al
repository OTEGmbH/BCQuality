codeunit 50936 "Privacy FeatureTelemetry Bad"
{
    procedure LogExpenseReleased(EmployeeNo: Code[20]; UserName: Text)
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('EmployeeNo', EmployeeNo);
        CustomDimensions.Add('UserName', UserName);
        CustomDimensions.Add('LastError', GetLastErrorText());

        FeatureTelemetry.LogUsage('0000EA1', 'Expense Agent', 'Document Released', CustomDimensions);
    end;
}
