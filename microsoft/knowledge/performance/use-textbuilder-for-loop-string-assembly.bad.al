codeunit 50932 "Perf Sample TextConcat Bad"
{
    procedure BuildItemList(var Item: Record Item): Text
    var
        Result: Text;
    begin
        if Item.FindSet() then
            repeat
                Result += StrSubstNo('%1,%2', Item."No.", Item.Description);
            until Item.Next() = 0;

        exit(Result);
    end;
}
