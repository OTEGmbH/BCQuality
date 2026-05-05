page 50730 "UI Caption Good"
{
    layout
    {
        area(Content)
        {
            group(Description)
            {
                Caption = 'Description';
                field(DescriptionField; Rec.Description)
                {
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
            field(CustomerName; Rec."Customer Name")
            {
            }
        }
    }
}
