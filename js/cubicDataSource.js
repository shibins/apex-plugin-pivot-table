! function (jet, $, server, util, debug) {
    "use strict";
    
    const DELIMITER           = "_";
    const DEFAULT_COLUMNSTYLE = "width: 100px;height:75px;text-align: center;overflow-wrap: break-word;" ;
    const DEFAULT_CELLSTYLE   = "text-align: center;vertical-align:middle;";
    const DEFAULT_ROWSTYLE    = "width: 150px;height:60px;overflow-wrap: break-word;";

    function replaceSpaceWithChar(str) {
        return str.replace(/\s+/g, DELIMITER);
    }

    function replaceCharWithSpace(str) {
        return str.replace(/_/g, " ")
    }

    jet.cubicdatasource = {
        init: function (pRegionId, pApexAjaxIdentifier, config  , cellrender,columnrender, rowrender) {
            require(["ojs/ojcore",   'jquery',   'ojs/ojmodel',  'promise',  'ojs/ojdatagrid',  'ojs/ojarraydatagriddatasource','ojs/ojcube'], function (oj,   $) {

                function generateCube(dataArr, axes) {
                    return new oj.DataValueAttributeCube(dataArr, axes, config.dataValues);
                }

                function dataGridModel(dataArr) {
 
                    var axes = config.layout;
                    return new oj.CubeDataGridDataSource(generateCube(dataArr, axes));

                };
            
                server.plugin(pApexAjaxIdentifier, {}, {
                    success: function (pData) {

                        var dataSource = dataGridModel(pData.items);
                    
                        $(pRegionId).ojDataGrid({
                            "data"     : dataSource,
                            "cell"     : {
                                "style"    :  typeof config.cellstyle !== "undefined" ?  config.cellstyle : DEFAULT_CELLSTYLE,
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
                                    
                                    "style":  typeof config.columnstyle !== "undefined" ?  config.columnstyle :DEFAULT_COLUMNSTYLE,
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

                                    "style": typeof config.rowstyle !== "undefined" ?  config.rowstyle :DEFAULT_ROWSTYLE,
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
                         
                    }
                });

            });
        }
    }
}(window.jet = window.jet || {}, apex.jQuery, apex.server, apex.util, apex.debug);

