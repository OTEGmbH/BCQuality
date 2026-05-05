page 50735 "UI Style Bad"
{
    layout
    {
        area(Content)
        {
            field(Score; Score)
            {
                Caption = 'Score';
                Style = Favorable;
                StyleExpr = IsGood;
            }
        }
    }

    var
        Score: Integer;
        IsGood: Boolean;
}
