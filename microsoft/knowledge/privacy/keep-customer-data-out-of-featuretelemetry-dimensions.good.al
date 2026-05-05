codeunit 50935 "Privacy FeatureTelemetry Good"
{
    procedure LogExpenseReleased()
    var
        FeatureTelemetry: Codeunit "Feature Telemetry";
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('DocumentType', 'Expense');
        CustomDimensions.Add('LineCountBucket', '10-20');

        FeatureTelemetry.LogUsage('0000EA1', 'Expense Agent', 'Document Released', CustomDimensions);
    end;
}
