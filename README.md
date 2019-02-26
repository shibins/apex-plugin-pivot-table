# Oracle APEX Region Plugin - Pivot Table 
Region Plugin


## Changelog

#### 1.0.0 - Initial Release


## Install

- Import Plugin File **region_type_plugin_com_oracle_apex_jet_cubicdatasource.sql** from the main directory into your Application
- (Optional) Deploy the JS file from the **server/js** Directory on your Webserver and change the **File Prefix** to Webservers Folder.


## Plugin Settings

The implemented Plugin Settings  :
- **Configuration Object** -  configures dataValues, layout and styles 
eg 
```
{
	dataValues : [
	    { attribute: 'Current Quarter Consumed' },
	    { attribute: 'Consumed' },
	    { attribute: 'Available' },
	    { attribute: 'Next Quarter Demand' },
	    { attribute: 'Next Quarter Inbound' },
	    { attribute: '% Of Allocation' }
	],
	layout: [
	{
		axis: 0,
		levels: [
			{ attribute: 'Customer Type' },
			{ dataValue: true }
		]
	}, 
	{
		axis: 1,
		levels: [
			{ attribute: 'Product Line' },
			{ attribute: 'Property' },
			{ attribute: 'Units' },
		]
	}],
	cellstyle        :"text-align: center;vertical-align:middle;",
	columnstyle      :"width: 100px;height:75px;text-align: center;overflow-wrap: break-word;",
	rowstyle         :"width: 150px;height:60px;overflow-wrap: break-word;"
	
}
```

- **Cell Renderer** - A function in format function(cellContext) {} and retuns row data 
- **Column Render** - A function in format function(headerContext) {} and retuns row data 
- **Row Renderer**  - A function in format function(headerContext) {} and retuns row data 
- **Width**         - Enter Width in px for example 200px
- **Height**        - Enter Height in px for example 200px

## How to use
- Create a new Region based on the Plugin
- Add a SQL Statement like the example below. As this is the easiest example possible, you have to name the columns exactly like the example (both naming and lowercase). These column aliases are used to construct the correct JSON object.
```
select  
Product_Line          "Product Line",
PROPERTY              "Property" , 
CUSTOMER_TYPE         "Customer Type",
CURRENT_QUARTER       "Current Quarter",
Previous_Quarter      "Previous Quarter",
UNITS                 "Units",
LINK                  "Link",
sum(current_consumed) "Current Quarter Consumed" ,  
sum(CONSUMED) 	      "Consumed" ,
sum(AVAILABLE) 	      "Available" ,
sum(NEXT_DEMAND)      "Next Quarter Demand" ,
sum(NEXT_INBOUND)     "Next Quarter Inbound" ,
round(avg(round(consumed/(consumed + available) * 100,2))) "% Of Allocation",
sort_order 
from report_v 
group by  P_AND_L,PROPERTY  , CUSTOMER_TYPE,CURRENT_CYCLE,NEXT_CYCLE,UNITS,LINK,sort_order    order by sort_order 

```

## Demo Application
[https://apex.oracle.com/pls/apex/f?p=100:100](https://apex.oracle.com/pls/apex/f?p=100:100)

## Blogpost


## Preview
## ![](https://github.com/shibins/apex-plugin-pivot-table/blob/master/preview.png)
