Class Demo.Airport Extends (%Persistent, %Populate)
{

Property Name As %String;

Property Code As %String;

Property Location As Demo.Location;

ClassMethod DisplayAirports() As %Status
{
	&sql(DECLARE c1 CURSOR FOR
       	SELECT Name, Code, Location->City, Location->State INTO :name, :code, :city, :state
       	FROM Demo.Airport)
       	
	&sql(OPEN c1)
	&sql(FETCH c1)
	WRITE "Airport",?35,"Code",?45,"Location",!
	WHILE (SQLCODE = 0) {
		WRITE name,?35,code,?45, city,",",state,!
	   	&sql(FETCH c1) 
	}
	&sql(CLOSE c1)
		
	Quit $$$OK
}

ClassMethod PopAirports() As %Status
{
	//1. Boston
	set newAirport = ##class(Demo.Airport).%New()
	set newAirport.Name = "Boston Logan International"
	set newAirport.Code = "BOS"
	set newAirport.Location = ##class(Demo.Location).%New()
	set newAirport.Location.City = "Boston"
	set newAirport.Location.State = "MA"
	do newAirport.%Save()
	
	//2. Philadephia
	set newAirport = ##class(Demo.Airport).%New()
	set newAirport.Name = "Philadephia International"
	set newAirport.Code = "PHL"
	set newAirport.Location = ##class(Demo.Location).%New()
	set newAirport.Location.City = "Philadelphia"
	set newAirport.Location.State = "PA"
	do newAirport.%Save()
	
	//3. Austin
	set newAirport = ##class(Demo.Airport).%New()
	set newAirport.Name = "Austin–Bergstrom International"
	set newAirport.Code = "AUS"
	set newAirport.Location = ##class(Demo.Location).%New()
	set newAirport.Location.City = "Austin"
	set newAirport.Location.State = "TX"
	do newAirport.%Save()
	
	//4. San Francisco
	set newAirport = ##class(Demo.Airport).%New()
	set newAirport.Name = "San Francisco International"
	set newAirport.Code = "SFO"
	set newAirport.Location = ##class(Demo.Location).%New()
	set newAirport.Location.City = "San Francisco"
	set newAirport.Location.State = "CA"
	do newAirport.%Save()	
	
	//5. O'hare
	set newAirport = ##class(Demo.Airport).%New()
	set newAirport.Name = "O'hare International"
	set newAirport.Code = "ORD"
	set newAirport.Location = ##class(Demo.Location).%New()
	set newAirport.Location.City = "Chicago"
	set newAirport.Location.State = "IL"
	do newAirport.%Save()
	
	quit $$$OK
}

ClassMethod StoreAirfare(fromAirport As %String, toAirport As %String) As %Status
{
	set ^AIRPORT("BOS") = "Boston Logan Airport^Boston^MA"
	set ^AIRPORT("AUS") = "Austin International Airport^Austin^TX"
	set ^AIRPORT("BOS","AUS") = 1698
	set ^AIRPORT("BOS","AUS","AA150") = 450
	set ^AIRPORT("BOS","AUS","AA290") = 550
	set ^AIRPORT("BOS","PHL","UA110") = 200
	set ^AIRPORT("BOS","BIS","AA330") = 700
	set ^AIRPORT("BOS","BIS","UA208") = 710
	
	set ifHasRoutes = ". This path has no routes"
    set isDefined = $data(^AIRPORT(fromAirport,toAirport))
    if ((isDefined = 11) || (isDefined = 1)) { set ifHasRoutes = ". This path has routes" }
    write $$$NL, "Printed to ^AIRPORT global. The distance in miles between " _ fromAirport _ " and " _ toAirport _ " is: " _ $get(^AIRPORT(fromAirport, toAirport)) _ ifHasRoutes

	quit $$$OK
}

Storage Default
{
<Data name="AirportDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Code</Value>
</Value>
<Value name="4">
<Value>Location</Value>
</Value>
</Data>
<DataLocation>^Demo.AirportD</DataLocation>
<DefaultData>AirportDefaultData</DefaultData>
<ExtentSize>10</ExtentSize>
<IdLocation>^Demo.AirportD</IdLocation>
<IndexLocation>^Demo.AirportI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>1.1</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Code">
<AverageFieldSize>4.8</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<Property name="Location">
<AverageFieldSize>1</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>17.3</AverageFieldSize>
<Selectivity>10.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^Demo.AirportS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
