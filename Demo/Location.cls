Class Demo.Location Extends (%Persistent, %Populate)
{

Property City As %String;

Property State As %String;

Property Longitude As %Decimal;

Property Latitude As %Decimal;

Storage Default
{
<Data name="LocationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>State</Value>
</Value>
<Value name="4">
<Value>Longitude</Value>
</Value>
<Value name="5">
<Value>Latitude</Value>
</Value>
</Data>
<DataLocation>^Demo.LocationD</DataLocation>
<DefaultData>LocationDefaultData</DefaultData>
<IdLocation>^Demo.LocationD</IdLocation>
<IndexLocation>^Demo.LocationI</IndexLocation>
<StreamLocation>^Demo.LocationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
