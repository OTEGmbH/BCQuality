page 50734 "UI Style Good"
{
    layout
    {
        area(Content)
        {
            field(ValidationStatus; ValidationStatus)
            {
                Caption = 'Validation status';
                Style = Unfavorable;
                StyleExpr = HasValidationErrors;
            }
        }
    }

    var
        ValidationStatus: Text;
        HasValidationErrors: Boolean;
}
