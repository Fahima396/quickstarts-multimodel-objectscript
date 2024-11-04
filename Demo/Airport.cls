/// Purpose: This class shows a multimodel example in ObjectScript. SQL is used to display airports,
/// objects are stored directly, and a custom data structure is used to determine airfare.
Class Demo.Airport Extends %Persistent [ DdlAllowed ]
{

Property Name As %String;

Property Code As %String;

Property Location As Demo.Location;

/// Display all airports using cursor-based embedded SQL
ClassMethod DisplayAirports() As %Status
{
	&sql(DECLARE c1 CURSOR FOR
       	SELECT Name, Code, Location->City, Location->State INTO :name, :code, :city, :state
       	FROM Demo.Airport)
       	
	&sql(OPEN c1)
	&sql(FETCH c1)
	write "Airport",?35,"Code",?45,"Location",!
	while (SQLCODE = 0) {
		write name,?35,code,?45, city,",",state,!
	   	&sql(FETCH c1) 
	}
	&sql(CLOSE c1)
		
	quit $$$OK
}

/// Store objects directly to the database
ClassMethod PopulateAirports() As %Status
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

/// Create a custom data structure to store airfare in a graph-like structure and retrieve airfare based on nodes
/// Takes departure airport and arrival airport as arguments
ClassMethod StoreAirfare() As %Status
{
	set ^airport("BOS","AUS") = 1698
	set ^airport("BOS","AUS","AA150") = 450
	set ^airport("BOS","AUS","AA290") = 550
	
	set ^airport("BOS","PHL") = 280
	set ^airport("BOS","PHL","UA110") = 200
	
	set ^airport("BOS","BIS") = 1490
	set ^airport("BOS","BIS","AA330") = 700
	set ^airport("BOS","BIS","UA208") = 710
	
	write "Stored fare and distance data in ^airport global."
	quit $$$OK
}

ClassMethod CheckAirfare(fromAirport As %String, toAirport As %String) As %Status
{
    write !,"The distance in miles between " _ fromAirport _ " and "_ toAirport _ " is: " _ $get(^airport(fromAirport, toAirport)) 
    set isDefined = $data(^airport(fromAirport,toAirport))
    if ((isDefined = 11)) { 
    	write !,"The following routes exist for this path:"
    	set flightNumber = ""
    	while ($order(^airport(fromAirport,toAirport, flightNumber)) '= ""){
    		set flightNumber = $order(^airport(fromAirport,toAirport, flightNumber))
    		set fare = ^airport(fromAirport,toAirport, flightNumber)
    		write !,"  - " _ flightNumber _ ": " _ fare _ " USD"
    	}
    }
    else{
	    write "No routes exist for this path."
	}
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
<IdLocation>^Demo.AirportD</IdLocation>
<IndexLocation>^Demo.AirportI</IndexLocation>
<StreamLocation>^Demo.AirportS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
