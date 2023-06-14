# multimodel-objectscript-quickstart

## In this repo
├── Demo  
│   ├── Airport.cls  
│   └── Location.cls  
└── README.md  

## Guided Tutorial
For a guided tutorial using this sample, visit [Accessing Data in ObjectScript Using Multiple Data Models](https://learning.intersystems.com/course/view.php?name=ObjectScriptMultiModel) on the InterSystems learning site.

## How to use this sample on your own
This sample shows how to access data using object, relational, and native data models from an ObjectScript application. Airport data is stored using objects, and retrieved using SQL. A custom data structure is created using globals to handle route information between airports.

1. Start with a running InterSystems IRIS instance.
2. Clone this repository.
3. Import the Demo package from this repository into your IRIS instance.
4. Compile the Demo pacakge.
5. In an InterSystems IRIS terminal, run the following commands. Inspect the code and output.

```
do ##class(Demo.Airport).PopulateAirports()  
do ##class(Demo.Airport).DisplayAirports()  
do ##class(Demo.Airport).StoreAirfare()  
do ##class(Demo.Airport).CheckAirfare("BOS","AUS")  
```