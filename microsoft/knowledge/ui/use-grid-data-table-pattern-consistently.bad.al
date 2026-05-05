page 50733 "UI Grid Bad"
{
    layout
    {
        area(Content)
        {
            grid(BalanceGrid)
            {
                GridLayout = Columns;
                field(CustomerName; Rec."Customer Name")
                {
                    ShowCaption = false;
                }
                group(BalanceColumn)
                {
                    field(Balance; Rec.Balance)
                    {
                        ShowCaption = false;
                    }
                }
            }
        }
    }
}
