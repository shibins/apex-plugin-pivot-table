prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180200 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.05.24'
,p_release=>'18.2.0.00.12'
,p_default_workspace_id=>4463938875366982
,p_default_application_id=>1004
,p_default_owner=>'SAASKPI'
);
end;
/
prompt --application/shared_components/plugins/region_type/com_oracle_apex_jet_cubicdatasource
begin
wwv_flow_api.create_plugin(
 p_id=>wwv_flow_api.id(110688608404666119)
,p_plugin_type=>'REGION TYPE'
,p_name=>'COM.ORACLE.APEX.JET.CUBICDATASOURCE'
,p_display_name=>'JET Cubic Data Source'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'[require jet]#PLUGIN_FILES#cubicDataSource.js',
''))
,p_css_file_urls=>'#JET_CSS_DIRECTORY#alta/oj-alta-notag-min.css'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/*',
' * render - function to create placeholder div tag, and initialise the  component',
'*/',
'FUNCTION render (',
'    p_region                IN                      apex_plugin.t_region,',
'    p_plugin                IN                      apex_plugin.t_plugin,',
'    p_is_printer_friendly   IN                      BOOLEAN',
') RETURN apex_plugin.t_region_render_result IS',
'    c_region_static_id       CONSTANT VARCHAR2(255) := apex_escape.html_attribute(p_region.static_id);',
'    v_configuration_object   apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_05, ''null'');',
'    v_cell_renderer          apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_07, ''null'');',
'    v_column_renderer        apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_08, ''null'');',
'    v_row_renderer           apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_09, ''null'');',
'    v_width                  apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_10, ''2000px'');',
'    v_height                 apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_11, ''2000px'');',
'    v_classrender            apex_application_page_regions.attribute_02%TYPE := nvl(p_region.attribute_12, ''null'');',
'BEGIN',
'        apex_css.add_file(p_name => ''cds-'', p_directory => p_plugin.file_prefix, p_version => ''1.0.0'');',
'        -- Add placeholder div',
'',
'        sys.htp.p(''<div class="a-JET-CubicDataSource" id="''',
'                  || c_region_static_id',
'                  || ''_region">''',
'                  || ''<div  aria-label="Data Grid Cell Based Grid Demo" style="width:''',
'                  || v_width',
'                  || '';height:''',
'                  ||  v_height ',
'                  || ''"  class="a-JET-CubicDataSource-container" id="''',
'                  || c_region_static_id',
'                  || ''_data"></div>''',
'                  || ''</div>'');',
'     ',
'        -- Initialize the chart',
'',
'          apex_javascript.add_onload_code',
'          ( p_code => ''jet.cubicdatasource.init(''||',
'                          ''"#''||c_region_static_id||''_data", ''   || -- pRegionId',
'                          ''"'' || apex_plugin.get_ajax_identifier ||''",''   || -- pApexAjaxIdentifier',
'                          ''''  || v_configuration_object          ||'',''     || -- v_configuration_object',
'                          ''''  || v_cell_renderer                 ||'',''     || -- v_cell_renderer',
'                          ''''  || v_column_renderer               ||'',''     || -- v_column_renderer',
'                          ''''  || v_row_renderer                  ||'',''      || -- v_row_renderer',
'                          ''''  || v_classRender                    ||''''      || -- v_classRender',
'',
'',
'',
'                         '')''',
'          );',
'  ',
'          /*apex_javascript.add_inline_code (',
'            p_code => ''function initMySuperWidget(){''||chr(10)||',
'                      ''  // do something''||chr(10)||',
'                      ''};'',',
'            p_key  => ''my_super_widget_function'' );',
'            */',
'',
'        RETURN NULL;',
'    END render;',
'',
'/*',
' * ajax - function to process SQL query, and output JSON data for legend',
' */',
'',
'    FUNCTION ajax (',
'        p_region   IN         apex_plugin.t_region,',
'        p_plugin   IN         apex_plugin.t_plugin',
'    ) RETURN apex_plugin.t_region_ajax_result IS',
'',
'        c                SYS_REFCURSOR;',
'        l_query          VARCHAR2(32767);',
'        l_context        apex_exec.t_context;',
'        l_columns        apex_exec.t_columns;',
'        l_column         apex_exec.t_column;',
'        l_idx            PLS_INTEGER := 0;',
'        l_column_idx     PLS_INTEGER := 0;',
'        l_column_count   PLS_INTEGER := 0;',
'    BEGIN',
'        l_query := p_region.source;',
'        -- open c for l_query;',
'        apex_json.open_object;',
'        --apex_json.write(''items'', c);',
'        -- add settings',
'        apex_json.write(''animationOnDisplay'', p_region.attribute_01);',
'        apex_json.write(''columnCount'', p_region.attribute_02);',
'        apex_json.write(''layout'', p_region.attribute_03);',
'        l_context := apex_exec.open_query_context(p_columns => l_columns, p_max_rows => 100000);',
'        l_column_count := apex_exec.get_column_count(l_context);',
'        apex_json.open_array(''items'');',
'        ',
'        WHILE apex_exec.next_row(p_context => l_context) LOOP',
'            l_idx := l_idx + 1;',
'            apex_json.open_object;',
'            FOR l_column_idx IN 1..l_column_count LOOP',
'                l_column := apex_exec.get_column(l_context, l_column_idx);',
'                IF l_column.data_type = apex_exec.c_data_type_date THEN',
'                    apex_json.write(l_column.name, apex_exec.get_varchar2(l_context, l_column_idx));',
'                ELSIF l_column.data_type = apex_exec.c_data_type_timestamp THEN',
'                    apex_json.write(l_column.name, apex_exec.get_timestamp(l_context, l_column_idx));',
'                ELSIF l_column.data_type = apex_exec.c_data_type_timestamp_tz THEN',
'                    apex_json.write(l_column.name, apex_exec.get_timestamp_tz(l_context, l_column_idx));',
'                ELSIF l_column.data_type = apex_exec.c_data_type_timestamp_ltz THEN',
'                    apex_json.write(l_column.name, apex_exec.get_timestamp_ltz(l_context, l_column_idx));',
'                ELSIF l_column.data_type = apex_exec.c_data_type_interval_y2m THEN',
'                    apex_json.write(l_column.name, apex_exec.get_varchar2(l_context, l_column_idx));',
'                ELSIF l_column.data_type = apex_exec.c_data_type_number THEN',
'                    apex_json.write(l_column.name, apex_exec.get_number(l_context, l_column_idx));',
'                ELSE',
'                    apex_json.write(l_column.name, apex_exec.get_varchar2(l_context, l_column_idx));',
'                END IF;',
'',
'            END LOOP;',
'',
'            apex_json.close_object;',
'        END LOOP;',
'',
'        apex_json.close_array;',
'        apex_json.close_object;',
'        apex_exec.close(l_context);',
'        RETURN NULL;',
'      exception ',
'        when others then',
'            apex_exec.close( l_context );',
'                raise;      ',
'    END ajax;',
''))
,p_api_version=>1
,p_render_function=>'render'
,p_ajax_function=>'ajax'
,p_standard_attributes=>'SOURCE_LOCATION:AJAX_ITEMS_TO_SUBMIT:ESCAPE_OUTPUT:INIT_JAVASCRIPT_CODE:VALUE_ESCAPE_OUTPUT'
,p_substitute_attributes=>false
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0.0'
,p_files_version=>180
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(110838699352430011)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'animationOnDisplay'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'auto'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110839122676430950)
,p_plugin_attribute_id=>wwv_flow_api.id(110838699352430011)
,p_display_sequence=>10
,p_display_value=>'auto'
,p_return_value=>'auto'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110839617596432049)
,p_plugin_attribute_id=>wwv_flow_api.id(110838699352430011)
,p_display_sequence=>20
,p_display_value=>'popIn'
,p_return_value=>'popIn'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110839948522432803)
,p_plugin_attribute_id=>wwv_flow_api.id(110838699352430011)
,p_display_sequence=>30
,p_display_value=>'alphaFade'
,p_return_value=>'alphaFade'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110840399508433404)
,p_plugin_attribute_id=>wwv_flow_api.id(110838699352430011)
,p_display_sequence=>40
,p_display_value=>'zoom'
,p_return_value=>'zoom'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110840770853433914)
,p_plugin_attribute_id=>wwv_flow_api.id(110838699352430011)
,p_display_sequence=>50
,p_display_value=>'none'
,p_return_value=>'none'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(110841353609439706)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'columnCount'
,p_attribute_type=>'INTEGER'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'5'
,p_display_length=>3
,p_max_length=>3
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(110842512979446017)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'layout'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_show_in_wizard=>false
,p_default_value=>'horizontal'
,p_supported_ui_types=>'DESKTOP:JQM_SMARTPHONE'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110843090334446443)
,p_plugin_attribute_id=>wwv_flow_api.id(110842512979446017)
,p_display_sequence=>10
,p_display_value=>'vertical'
,p_return_value=>'vertical'
);
wwv_flow_api.create_plugin_attr_value(
 p_id=>wwv_flow_api.id(110843492488447198)
,p_plugin_attribute_id=>wwv_flow_api.id(110842512979446017)
,p_display_sequence=>20
,p_display_value=>'horizontal'
,p_return_value=>'horizontal'
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57462337897290444)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Configuration Object'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57604452575898885)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Layout'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57609397173039525)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Cell Renderer'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(cellContext) {',
'',
'}'))
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57613939687125777)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Column Render'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(headerContext) { }',
''))
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57614596967121837)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Row Renderer'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_default_value=>'function(headerContext) {}'
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57684517906700564)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>10
,p_display_sequence=>100
,p_prompt=>'Width'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(57685073768696680)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>11
,p_display_sequence=>110
,p_prompt=>'Height'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_attribute(
 p_id=>wwv_flow_api.id(58456818724126907)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>12
,p_display_sequence=>120
,p_prompt=>'Cell Class Render'
,p_attribute_type=>'TEXTAREA'
,p_is_required=>false
,p_default_value=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function(cellContext) {',
' return "";',
'}'))
,p_is_translatable=>false
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(1851572411379227)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_name=>'INIT_JAVASCRIPT_CODE'
,p_is_required=>false
);
wwv_flow_api.create_plugin_std_attribute(
 p_id=>wwv_flow_api.id(1856289145048974)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_name=>'SOURCE_LOCATION'
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '6F6A2D64617461677269642D63656C6C2D746578742C202E6F6A2D64617461677269642D6865616465722D63656C6C2D74657874207B0A2020202020202020706F736974696F6E3A206162736F6C7574653B0A2020202020202020626F74746F6D3A2030';
wwv_flow_api.g_varchar2_table(2) := '3B0A20202020202020206C6566743A20303B0A202020202020202077696474683A20313030253B0A20202020202020206C696E652D6865696768743A323B0A2020202020202020666F6E742D73697A653A302E38656D203B0A7D0A0A2E6F6A2D64617461';
wwv_flow_api.g_varchar2_table(3) := '677269642D6865616465722D63656C6C2D636F6E74656E74207B0A2020202020202020706F736974696F6E3A2072656C61746976653B0A20202020202020206865696768743A20313030253B0A202020202020202077696474683A20313030253B0A2020';
wwv_flow_api.g_varchar2_table(4) := '2020202020206F766572666C6F773A2068696464656E3B0A202020202020202077686974652D73706163653A206E6F726D616C3B0A2020202020202020666F6E742D73697A653A20312E3572656D3B0A0A7D0A0A2E6F6A2D64617461677269642D63656C';
wwv_flow_api.g_varchar2_table(5) := '6C207B0A20202020666F6E742D73697A653A20312E3572656D3B0A20202020200A7D0A0A0A2E6F6A2D64617461677269642D746F702D636F726E65727B0A096261636B67726F756E642D636F6C6F723A236632663466370A7D0A0A2E6F6A2D627574746F';
wwv_flow_api.g_varchar2_table(6) := '6E2D74657874207B0A2020666F6E742D73697A653A20312E3372656D3B20200A7D0A0A2E6F6A2D64617461677269642D63656C6C2D636F6E74656E74207B0A09746F703A2D313070783B0A7D0A0A0A2F2A2054686520737469636B7920636C6173732069';
wwv_flow_api.g_varchar2_table(7) := '7320616464656420746F20746865206865616465722077697468204A53207768656E206974207265616368657320697473207363726F6C6C20706F736974696F6E202A2F0A2E737469636B79207B0A2020706F736974696F6E3A2066697865643B0A2020';
wwv_flow_api.g_varchar2_table(8) := '746F703A2D3170783B0A7D0A0A2F2A205061676520636F6E74656E74202A2F0A2E636F6E74656E74207B0A202070616464696E673A20313670783B0A7D0A0A0A2F2A2041646420736F6D6520746F702070616464696E6720746F20746865207061676520';
wwv_flow_api.g_varchar2_table(9) := '636F6E74656E7420746F2070726576656E742073756464656E20717569636B206D6F76656D656E7420286173207468652068656164657220676574732061206E657720706F736974696F6E2061742074686520746F70206F662074686520706167652028';
wwv_flow_api.g_varchar2_table(10) := '706F736974696F6E3A666978656420616E6420746F703A3029202A2F0A2E737469636B79202B202E636F6E74656E74207B0A202070616464696E672D746F703A2031303270783B0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(57616153032558870)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_file_name=>'cds-1.0.0-min.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '6F6A2D64617461677269642D63656C6C2D746578742C202E6F6A2D64617461677269642D6865616465722D63656C6C2D74657874207B0A2020202020202020706F736974696F6E3A206162736F6C7574653B0A2020202020202020626F74746F6D3A2030';
wwv_flow_api.g_varchar2_table(2) := '3B0A20202020202020206C6566743A20303B0A202020202020202077696474683A20313030253B0A20202020202020206C696E652D6865696768743A323B0A2020202020202020666F6E742D73697A653A302E38656D203B0A7D0A0A2E6F6A2D64617461';
wwv_flow_api.g_varchar2_table(3) := '677269642D6865616465722D63656C6C2D636F6E74656E74207B0A2020202020202020706F736974696F6E3A2072656C61746976653B0A20202020202020206865696768743A20313030253B0A202020202020202077696474683A20313030253B0A2020';
wwv_flow_api.g_varchar2_table(4) := '2020202020206F766572666C6F773A2068696464656E3B0A202020202020202077686974652D73706163653A206E6F726D616C3B0A2020202020202020666F6E742D73697A653A20312E3572656D3B0A0A7D0A0A2E6F6A2D64617461677269642D63656C';
wwv_flow_api.g_varchar2_table(5) := '6C207B0A20202020666F6E742D73697A653A20312E3572656D3B0A20202020200A7D0A0A0A2E6F6A2D64617461677269642D746F702D636F726E65727B0A096261636B67726F756E642D636F6C6F723A236632663466370A7D0A0A2E6F6A2D627574746F';
wwv_flow_api.g_varchar2_table(6) := '6E2D74657874207B0A2020666F6E742D73697A653A20312E3372656D3B20200A7D0A0A2E6F6A2D64617461677269642D63656C6C2D636F6E74656E74207B0A09746F703A2D313070783B0A7D0A0A0A2F2A2054686520737469636B7920636C6173732069';
wwv_flow_api.g_varchar2_table(7) := '7320616464656420746F20746865206865616465722077697468204A53207768656E206974207265616368657320697473207363726F6C6C20706F736974696F6E202A2F0A2E737469636B79207B0A2020706F736974696F6E3A2066697865643B0A2020';
wwv_flow_api.g_varchar2_table(8) := '746F703A2D3170783B0A7D0A0A2F2A205061676520636F6E74656E74202A2F0A2E636F6E74656E74207B0A202070616464696E673A20313670783B0A7D0A0A0A2F2A2041646420736F6D6520746F702070616464696E6720746F20746865207061676520';
wwv_flow_api.g_varchar2_table(9) := '636F6E74656E7420746F2070726576656E742073756464656E20717569636B206D6F76656D656E7420286173207468652068656164657220676574732061206E657720706F736974696F6E2061742074686520746F70206F662074686520706167652028';
wwv_flow_api.g_varchar2_table(10) := '706F736974696F6E3A666978656420616E6420746F703A3029202A2F0A2E737469636B79202B202E636F6E74656E74207B0A202070616464696E672D746F703A2031303270783B0A7D';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(57616481230558867)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_file_name=>'cds-1.0.0.css'
,p_mime_type=>'text/css'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.g_varchar2_table := wwv_flow_api.empty_varchar2_table;
wwv_flow_api.g_varchar2_table(1) := '212066756E6374696F6E20286A65742C20242C207365727665722C207574696C2C20646562756729207B0A202020202275736520737472696374223B0A202020200A20202020636F6E73742044454C494D49544552203D20225F223B0A202020200A2020';
wwv_flow_api.g_varchar2_table(2) := '202066756E6374696F6E207265706C616365537061636557697468436861722873747229207B0A202020202020202072657475726E207374722E7265706C616365282F5C732B2F672C2044454C494D49544552293B0A202020207D0A0A2020202066756E';
wwv_flow_api.g_varchar2_table(3) := '6374696F6E207265706C616365436861725769746853706163652873747229207B0A202020202020202072657475726E207374722E7265706C616365282F5F2F672C20222022290A202020207D0A0A202020206A65742E637562696364617461736F7572';
wwv_flow_api.g_varchar2_table(4) := '6365203D207B0A2020202020202020696E69743A2066756E6374696F6E202870526567696F6E49642C207041706578416A61784964656E7469666965722C20636F6E66696720202C2063656C6C72656E6465722C636F6C756D6E72656E6465722C20726F';
wwv_flow_api.g_varchar2_table(5) := '7772656E6465722C636C61737352656E64657229207B0A20202020202020202020202072657175697265285B226F6A732F6F6A636F7265222C202020276A7175657279272C202020276F6A732F6F6A6D6F64656C272C20202770726F6D697365272C2020';
wwv_flow_api.g_varchar2_table(6) := '276F6A732F6F6A6461746167726964272C2020276F6A732F6F6A6172726179646174616772696464617461736F75726365272C276F6A732F6F6A63756265275D2C2066756E6374696F6E20286F6A2C2020202429207B0A0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(7) := '2020202066756E6374696F6E2067656E65726174654375626528646174614172722C206178657329207B0A202020202020202020202020202020202020202072657475726E206E6577206F6A2E4461746156616C75654174747269627574654375626528';
wwv_flow_api.g_varchar2_table(8) := '646174614172722C20617865732C20636F6E6669672E6461746156616C756573293B0A202020202020202020202020202020207D0A0A2020202020202020202020202020202066756E6374696F6E2064617461477269644D6F64656C2864617461417272';
wwv_flow_api.g_varchar2_table(9) := '29207B0A200A20202020202020202020202020202020202020207661722061786573203D20636F6E6669672E6C61796F75743B0A202020202020202020202020202020202020202069662028646174614172722E6C656E677468203E20302029207B0A20';
wwv_flow_api.g_varchar2_table(10) := '202020202020202020202020202020202020202020202072657475726E206E6577206F6A2E43756265446174614772696444617461536F757263652867656E65726174654375626528646174614172722C206178657329293B0A20202020202020202020';
wwv_flow_api.g_varchar2_table(11) := '202020202020202020207D0A20202020202020202020202020202020202020200A0A202020202020202020202020202020207D3B0A2020202020202020202020200A202020202020202020202020202020207365727665722E706C7567696E2870417065';
wwv_flow_api.g_varchar2_table(12) := '78416A61784964656E7469666965722C207B7D2C207B0A20202020202020202020202020202020737563636573733A2066756E6374696F6E2028704461746129207B0A0A20202020202020202020202020202020202020207661722064617461536F7572';
wwv_flow_api.g_varchar2_table(13) := '6365203D2064617461477269644D6F64656C2870446174612E6974656D73293B0A20202020202020202020202020202020202020200A2020202020202020202020202020202020202020242870526567696F6E4964292E6F6A4461746147726964287B0A';
wwv_flow_api.g_varchar2_table(14) := '20202020202020202020202020202020202020202020202022646174612220202020203A2064617461536F757263652C0A2020202020202020202020202020202020202020202020202263656C6C2220202020203A207B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(15) := '20202020202020202020202020202020227374796C6522202020203A2020747970656F6620636F6E6669672E63656C6C7374796C6520213D3D2022756E646566696E656422203F2020636F6E6669672E63656C6C7374796C65203A2022746578742D616C';
wwv_flow_api.g_varchar2_table(16) := '69676E3A2063656E7465723B766572746963616C2D616C69676E3A6D6964646C653B222C0A20202020202020202020202020202020202020202020202020202020636C6173734E616D6520203A202066756E6374696F6E2863656C6C436F6E7465787429';
wwv_flow_api.g_varchar2_table(17) := '207B0A0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069662028747970656F6620636C61737352656E64657220213D3D2022756E646566696E65642229207B0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(18) := '20202020202020202020202020202020202020202020202020202020202072657475726E20636C61737352656E6465722863656C6C436F6E7465787429203B0A202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(19) := '202020207D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020656C73650A202020202020202020202020202020202020202020202020202020202020202020202020202020207B0A20202020202020';
wwv_flow_api.g_varchar2_table(20) := '202020202020202020202020202020202020202020202020202020202020202020202020200A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072657475726E2022223B0A20202020202020';
wwv_flow_api.g_varchar2_table(21) := '2020202020202020202020202020202020202020202020202020202020202020207D200A202020202020202020202020202020202020202020202020202020202020202020202020202020200A2020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(22) := '20202020207D2C0A202020202020202020202020202020202020202020202020202020202272656E646572657222203A2066756E6374696F6E2863656C6C436F6E7465787429207B0A202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(23) := '202020202069662028747970656F662063656C6C72656E64657220213D3D2022756E646566696E65642229207B0A20202020202020202020202020202020202020202020202020202020202020202020202072657475726E2063656C6C72656E64657228';
wwv_flow_api.g_varchar2_table(24) := '63656C6C436F6E7465787429203B0A20202020202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020202020202020202020656C73650A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(25) := '2020202020202020202020202020202020207B0A2020202020202020202020202020202020202020202020202020202020202020202020207661722064617461203D2063656C6C436F6E746578745B2764617461275D3B0A202020202020202020202020';
wwv_flow_api.g_varchar2_table(26) := '20202020202020202020202020202020202020202020202072657475726E20646174613B0A20202020202020202020202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020202020207D';
wwv_flow_api.g_varchar2_table(27) := '2C0A2020202020202020202020202020202020202020202020207D2C0A20202020202020202020202020202020202020202020202022686561646572223A207B0A2020202020202020202020202020202020202020202020202020202022636F6C756D6E';
wwv_flow_api.g_varchar2_table(28) := '223A207B0A2020202020202020202020202020202020202020202020202020202020202020202020202263656C6C223A207B2022636C6173734E616D65223A20226D7943656C6C5374796C6522207D2C0A20202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(29) := '2020202020202020202020202020202020227374796C65223A2020747970656F6620636F6E6669672E636F6C756D6E7374796C6520213D3D2022756E646566696E656422203F2020636F6E6669672E636F6C756D6E7374796C65203A2277696474683A20';
wwv_flow_api.g_varchar2_table(30) := '31303070783B6865696768743A373570783B746578742D616C69676E3A2063656E7465723B6F766572666C6F772D777261703A20627265616B2D776F72643B22202C0A202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(31) := '2020202272656E6465726572223A2066756E6374696F6E28686561646572436F6E7465787429207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202069662028747970656F6620636F6C756D6E7265';
wwv_flow_api.g_varchar2_table(32) := '6E64657220213D3D2022756E646566696E65642229207B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072657475726E20636F6C756D6E72656E64657228686561646572436F6E746578';
wwv_flow_api.g_varchar2_table(33) := '7429203B0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020656C73650A2020202020202020';
wwv_flow_api.g_varchar2_table(34) := '20202020202020202020202020202020202020202020202020202020202020207B0A20202020202020202020202020202020202020202020202020202020202020202020202020202020202020207661722064617461203D20686561646572436F6E7465';
wwv_flow_api.g_varchar2_table(35) := '78745B2764617461275D3B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072657475726E20646174613B0A20202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(36) := '2020202020202020207D0A2020202020202020202020202020202020202020202020202020202020202020202020207D2C0A20202020202020202020202020202020202020202020202020202020202020207D2C0A202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(37) := '202020202020202020202020202020202022726F77223A207B0A0A202020202020202020202020202020202020202020202020202020202020202020202020227374796C65223A20747970656F6620636F6E6669672E726F777374796C6520213D3D2022';
wwv_flow_api.g_varchar2_table(38) := '756E646566696E656422203F2020636F6E6669672E726F777374796C65203A2277696474683A2031353070783B6865696768743A363070783B6F766572666C6F772D777261703A20627265616B2D776F72643B222C0A2020202020202020202020202020';
wwv_flow_api.g_varchar2_table(39) := '202020202020202020202020202020202020202020202272656E6465726572223A2066756E6374696F6E28686561646572436F6E7465787429207B0A20202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(40) := '69662028747970656F6620726F7772656E64657220213D3D2022756E646566696E65642229207B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072657475726E20726F7772656E646572';
wwv_flow_api.g_varchar2_table(41) := '28686561646572436F6E7465787429203B0A202020202020202020202020202020202020202020202020202020202020202020202020202020207D0A20202020202020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(42) := '656C73650A202020202020202020202020202020202020202020202020202020202020202020202020202020207B0A2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020766172206461746120';
wwv_flow_api.g_varchar2_table(43) := '3D20686561646572436F6E746578745B2764617461275D3B0A202020202020202020202020202020202020202020202020202020202020202020202020202020202020202072657475726E20646174613B0A202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(44) := '202020202020202020202020202020202020202020207D0A202020202020202020202020202020202020202020202020202020202020202020202020202020200A2020202020202020202020202020202020202020202020202020202020202020202020';
wwv_flow_api.g_varchar2_table(45) := '207D2C0A20202020202020202020202020202020202020202020202020202020202020207D2C0A0A202020202020202020202020202020202020202020202020202020207D0A2020202020202020202020202020202020202020202020207D293B0A2020';
wwv_flow_api.g_varchar2_table(46) := '202020202020202020202020202020202020202020200A202020202020202020202020202020202020202020202020242870526567696F6E4964292E6F6A446174614772696428226F7074696F6E222C202262616E64696E67496E74657276616C222C20';
wwv_flow_api.g_varchar2_table(47) := '7B2022726F77223A2031207D293B0A0A202F2F2020202020202020202020202020202020202020202020242870526567696F6E4964292E6F6A446174614772696428226F7074696F6E222C276865616465722E726F77272C7B20226D65747269635F6E61';
wwv_flow_api.g_varchar2_table(48) := '6D65223A20226D65747269635F6E616D6522207D293B0A0A0A20202020202020202020202020202020202020207D0A202020202020202020202020202020207D293B0A0A2020202020202020202020207D293B0A20202020202020207D0A202020207D0A';
wwv_flow_api.g_varchar2_table(49) := '7D2877696E646F772E6A6574203D2077696E646F772E6A6574207C7C207B7D2C20617065782E6A51756572792C20617065782E7365727665722C20617065782E7574696C2C20617065782E6465627567293B0A0A';
null;
end;
/
begin
wwv_flow_api.create_plugin_file(
 p_id=>wwv_flow_api.id(110819310470900466)
,p_plugin_id=>wwv_flow_api.id(110688608404666119)
,p_file_name=>'cubicDataSource.js'
,p_mime_type=>'text/javascript'
,p_file_charset=>'utf-8'
,p_file_content=>wwv_flow_api.varchar2_to_blob(wwv_flow_api.g_varchar2_table)
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
