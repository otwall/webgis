<%@ page language="java" pageEncoding="UTF-8"%>
<!--分页查询共用的页面-->
<%@ include file="/common/paginateUtil.jsp"%>
  
    <script type="text/javascript" src="<%=jsPath%>/jquery/jquery.validate.js"></script><!--表单数据验证-->
    <script type="text/javascript" src="<%=jsPath%>/jquery/jquery.metadata.js"  charset="UTF-8"></script><!--表单数据验证-->
</head>

		<script type="text/javascript" charset="utf-8">
				
//删除表格的某一行，删除后，会自动刷新表格			
			function getOnlineColumn(value, rowData, rowIndex)
			{  
				var online = rowData.online;
				var html = online == "在线" ? "<span style='color:green;font-weight:bold;'>在线</span>" : "<span style='color:red'>离线</span>";
			    return html;
			}
			//编辑列
			function getEditActionColumn(value, rowData, rowIndex)
			{
				var entityId = rowData.vehicleId;
				var html =  "<a href=\"javascript:InfoWindow.viewVehicle('" + entityId+ "&input=true');\">" +" 查看</a>";
				return html;
			}
			$(document).ready(function() {
			     
                $("#queryForm").validate();
				$("#btnQuery").click(function(){
					var queryForm = $("#queryForm");
					if(queryForm.validate().form() == false)
						return;
					var depId = $("input[name='depId']").val();
					if(!depId || depId == 0)
					{
						$.messager.alert("提示","请选择车组!");
						return;
					}
				    Utility.loadGridWithParams();
				});
				//Utility.loadGridWithParams();
				  
				//创建下拉部门树
				Utility.createDepTree("depId");
				$("#status").change(function()
				{
				       var txt = $("#status").find("option:selected").text(); 
					   $("#statusName").val(txt);
				});
				
				$("#areaId").lookup({queryID:"selectEnclosureList"});
				
                $("#useType").lookup({category:"CargoType"});
			} );
		</script>
<body>
		<div id="container"style="height:100%" >		
			<div id="toolbar">
			<form id="queryForm" action="<%=ApplicationPath%>/report/queueVehicle.action">
			   <input type="hidden" name="queryId" value="selectOnlineVehicles" />	   
			   <input type="hidden" name="fileName" value="车辆上线状态" />	     	
			   <input type="hidden" name="statusName" id="statusName" value="所有" />	    
			  <table width="100%"  class="TableBlock">
			   			   <tr>
			   <td> 车牌号码: </td>
			    <td>			    <input type="text" name="plateNo" size="10"  id="plateNo">   </td>
          <td> 电子围栏 </td>
			    <td>			    
				<select id="areaId" name="areaId" class="required"></select>
				</td>
            <td>车辆组:</td>
			    <td>			
				<select id="depId" name="depId" style="width:200px;" class="required"></select>
				</td>
            </tr>
 <tr>
			  
           
            <td>上线状态</td>
			    <td>			  
				   <select name="status" id="status">
				       <option value="">所有</option>
				       <option value="online">上线</option>
				       <option value="offline">离线</option>
				   </select>
				</td>
				<td>物料类型:</td><td><select id="useType" name="useType"></td>
        <td colspan="4" align="left">
		 <a id="btnQuery" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" >查询</a>&nbsp;
		   <a id="btnReset" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-clear'" >重置</a>&nbsp;
		   <a id="btnExport" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" onclick="Utility.excelExport('<%=ApplicationPath%>/data/excelExport.action');">导出</a><!--调用utility.js-->
		   <span style="color:red;">(*离线状态下自动按照离线时长排序)</span>
        </td>
    </tr>
		</table>
		</form>	 
		
  </div>
			<table id="queryGrid" class="easyui-datagrid" title="" style="width:100%;"
						data-options="pagination:true,pageSize:15,singleSelect:true,rownumbers:true,striped:true,fitColumns: true,
						pageList: [15, 20, 50, 100, 150, 200],fit:true,toolbar:'#toolbar',
						url:'<%=ApplicationPath%>/report/queueVehicle.action',method:'post'">
					<thead>
						<tr>
							<th data-options="field:'plateNo'"  width="6%">车牌号</th>
							<th data-options="field:'depName1'"  width="12%">车组</th>
							<th data-options="field:'strDistance'"  width="8%">距离围栏(公里)</th>
							<th data-options="field:'location'"  width="32%">当前位置</th>
							<th data-options="field:'online',formatter:getOnlineColumn"  width="5%">上线状态</th>
							<th data-options="field:'sendTime'"  width="11%">定位时间</th>
							<th data-options="field:'offlineTimeSpan'"  width="10%">离线时长</th>
							<th data-options="field:'useType'"  width="8%">物料类型</th>
							<th data-options="field:'vehicleId',formatter:getEditActionColumn"  width="6%">查看</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>					
				</table>
			</div>
			<div class="spacer"></div>
			</div>

</body>

