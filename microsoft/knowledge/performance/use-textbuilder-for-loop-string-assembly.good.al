codeunit 50931 "Perf Sample TextBuilder Good"
{
    procedure BuildItemList(var Item: Record Item): Text
    var
        Builder: TextBuilder;
    begin
        if Item.FindSet() then
            repeat
                Builder.AppendLine(StrSubstNo('%1,%2', Item."No.", Item.Description));
            until Item.Next() = 0;

        exit(Builder.ToText());
    end;
}
