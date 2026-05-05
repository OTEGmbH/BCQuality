page 50732 "UI Grid Good"
{
    layout
    {
        area(Content)
        {
            grid(BalanceGrid)
            {
                GridLayout = Columns;
                group(CustomerColumn)
                {
                    ShowCaption = false;
                    field(CustomerName; Rec."Customer Name")
                    {
                        ShowCaption = false;
                    }
                }
                group(BalanceColumn)
                {
                    ShowCaption = false;
                    field(Balance; Rec.Balance)
                    {
                        ShowCaption = false;
                    }
                }
            }
        }
    }
}
