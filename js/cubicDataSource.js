! function (jet, $, server, util, debug) {
    "use strict";
    
    const DELIMITER = "_";
    
    function replaceSpaceWithChar(str) {
        return str.replace(/\s+/g, DELIMITER);
    }

    function replaceCharWithSpace(str) {
        return str.replace(/_/g, " ")
    }

    jet.cubicdatasource = {
        init: function (pRegionId, pApexAjaxIdentifier, config  , cellrender,columnrender, rowrender,classRender) {
            require(["ojs/ojcore",   'jquery',   'ojs/ojmodel',  'promise',  'ojs/ojdatagrid',  'ojs/ojarraydatagriddatasource','ojs/ojcube'], function (oj,   $) {

                function generateCube(dataArr, axes) {
                    return new oj.DataValueAttributeCube(dataArr, axes, config.dataValues);
                }

                function dataGridModel(dataArr) {
 
                    var axes = config.layout;
                    if (dataArr.length > 0 ) {
                        return new oj.CubeDataGridDataSource(generateCube(dataArr, axes));
                    }
                    

                };
            
                server.plugin(pApexAjaxIdentifier, {}, {
                success: function (pData) {

                    var dataSource = dataGridModel(pData.items);
                    
                    $(pRegionId).ojDataGrid({
                        "data"     : dataSource,
                        "cell"     : {
                            "style"    :  typeof config.cellstyle !== "undefined" ?  config.cellstyle : "text-align: center;vertical-align:middle;",
                            className  :  function(cellContext) {

                                        if (typeof classRender !== "undefined") {
                                            return classRender(cellContext) ;
                                        }
                                        else
                                        {
                                            
                                            return "";
                                        } 
                                        
                            },
                            "renderer" : function(cellContext) {
                                if (typeof cellrender !== "undefined") {
                                    return cellrender(cellContext) ;
                                }
                                else
                                {
                                    var data = cellContext['data'];
                                    return data;
                                }
                            },
                        },
                        "header": {
                            "column": {
                                    "cell": { "className": "myCellStyle" },
                                    "style":  typeof config.columnstyle !== "undefined" ?  config.columnstyle :"width: 100px;height:75px;text-align: center;overflow-wrap: break-word;" ,
                                    "renderer": function(headerContext) {
                                        if (typeof columnrender !== "undefined") {
                                            return columnrender(headerContext) ;
                                        }
                                        else
                                        {
                                            var data = headerContext['data'];
                                            return data;
                                        }
                                    },
                                },
                                "row": {

                                    "style": typeof config.rowstyle !== "undefined" ?  config.rowstyle :"width: 150px;height:60px;overflow-wrap: break-word;",
                                    "renderer": function(headerContext) {
                                        if (typeof rowrender !== "undefined") {
                                            return rowrender(headerContext) ;
                                        }
                                        else
                                        {
                                            var data = headerContext['data'];
                                            return data;
                                        }
                                        
                                    },
                                },

                            }
                        });
                        
                        $(pRegionId).ojDataGrid("option", "bandingInterval", { "row": 1 });

 //                       $(pRegionId).ojDataGrid("option",'header.row',{ "metric_name": "metric_name" });


                    }
                });

            });
        }
    }
}(window.jet = window.jet || {}, apex.jQuery, apex.server, apex.util, apex.debug);

