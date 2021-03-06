<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 't';
			var q_name = "uca";
			var decbbs = ['weight', 'uweight', 'price'];
			var decbbm = ['weight', 'hours', 'pretime', 'mount', 'wages', 'makes'/*, 'mechs', 'trans'*/, 'molds', 'packs', 'uweight', 'price'];
			var decbbt = [];
			var q_readonly = ['textCosta','txtModel','txtStationg', 'textCostb', 'textCostc', 'textCostd', 'textCostw', 'textCostm', 'textCostp', 'textCostt', 'textCosttotal', 'textStk', 'textOrdemount', 'textPlanmount', 'textIntmount', 'textAvaistk','txtMolds','txtRev','txtKdate','txtWdate','txtTeam'];
			var q_readonlys = [];
			var q_readonlyt = ['txtAssm'];
			var bbmNum = [['txtPrice', 15, 5, 1, 1],['txtPreday', 12, 0, 1],['txtHours', 10, 3, 1],['txtMinutes', 10, 3, 1],['txtSec', 2, 0, 1]
			,['txtBadperc', 15, 5, 1, 1],['txtUweight', 15, 3, 1],['txtMakes', 15, 2, 1],['txtPacks', 15, 2, 1],['txtWages', 15, 2, 1],['txtSafemount', 15, 2, 1],['txtStdmount', 15, 2, 1]];/*,['txtMechs', 15, 2, 1],['txtTrans', 15, 2, 1]*/
			var bbsNum = [['txtMount', 15, 5, 1, 1], ['txtHours', 9, 2,1],['txtLoss', 15, 5, 1, 1],['txtDividea', 10, 0,1],['txtMul', 10, 2,1]];
			var bbtNum = [['txtMount', 15, 5, 1, 1],['txtPrice', 12, 2, 1], ['txtEndmount', 12, 0, 1], ['txtEndweight', 15, 3, 1]
			,['txtMinutes', 10, 3, 1],['txtHminutes', 10, 3, 1],['txtSec', 2, 0, 1],['txtHsec', 2, 0, 1]
			,['txtLoss', 15, 5, 1, 1],['txtMakes', 15, 2, 1],['txtMakes_fee', 15, 2, 1],['txtWages', 15, 2, 1],['txtWages_fee', 15, 2, 1]
			];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 10;
			aPop = new Array(
				['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtComp', 'tgg_b.aspx'],
				['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtCust', 'cust_b.aspx'],
				['txtStyle', 'lblStyle_na', 'style', 'noa,product', 'txtStyle,txtTeam', 'style_b.aspx'],
				['txtBdate', 'lblBdate_na', 'ucc', 'noa,product', 'txtBdate,txtSize', 'ucc_b.aspx'],
				['txtEdate', 'lblEdate_na', 'ucc', 'noa,product', 'txtEdate,txtEngprono', 'ucc_b.aspx'],
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product,spec,unit', 'txtProductno_,txtProduct_,txtSpec_,txtUnit_', 'ucaucc_b.aspx'],
				['txtStationno', 'lblStation', 'station', 'noa,station,tggno,tgg', 'txtStationno,txtStation,txtStationtggno,txtStationtgg', 'station_b.aspx'],
				['txtStationno__', 'btnStation__', 'station', 'noa,station', 'txtStationno__,txtStation__', 'station_b.aspx'],
				['txtStationgno', 'lblStationg', 'stationg', 'noa,namea', 'txtStationgno,txtStationg', 'stationg_b.aspx'],
				['txtProcessno', 'lblProcess', 'process', 'noa,process', 'txtProcessno,txtProcess', 'process_b.aspx'],
				['txtProcessno_', 'btnProcessno_', 'process', 'noa,process', 'txtProcessno_,txtProcess_', 'process_b.aspx'],
				['txtTggno__', 'btnTggno__', 'tgg', 'noa,nick', 'txtTggno__,txtNick__', 'tgg_b.aspx'],
				['txtProcessno__', 'btnProcessno__', 'process', 'noa,process', 'txtProcessno__,txtProcess__', 'process_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
				q_brwCount();
				q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
			}).mousedown(function(e) {
				if(!$('#div_row').is(':hidden')){
					$('#div_row').hide();
				}
			});
			
			function currentData() {
			}
			currentData.prototype = {
				data : [],
				/*排除的欄位,新增時不複製*/
				exclude : [],
				/*記錄當前的資料*/
				copy : function() {
					curData.data = new Array();
					for (var i in fbbm) {
						var isExclude = false;
						for (var j in curData.exclude) {
							if (fbbm[i] == curData.exclude[j]) {
								isExclude = true;
								break;
							}
						}
						if (!isExclude) {
							curData.data.push({
								field : fbbm[i],
								value : $('#' + fbbm[i]).val()
							});
						}
					}
					for (var i in fbbs) {
						for(var j = 0; j < q_bbsCount; j++) {
							var isExcludes = false;
							for (var k in this.excludes) {
								if (fbbs[i] == this.excludes[k] ) {
									isExcludes = true;
									break;
								}
							}
							if (!isExcludes ) {
								this.data.push({
									field : fbbs[i]+'_'+j,
									value : $('#' + fbbs[i]+'_'+j).val()
								});
							}
						}
					}
				},
				/*貼上資料*/
				paste : function() {
					for (var i in curData.data) {
						$('#' + curData.data[i].field).val(curData.data[i].value);
					}
				}
			};
			
			var curData = new currentData();
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				q_mask(bbmMask);
				mainForm(0);
				$('#txtNoa').focus();
			}
			
			function mainPost() {
				q_getFormat();
				bbmMask = [['txtKdate', r_picd], ['txtWdate', r_picd]];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", q_getPara('uca.typea'));
				q_cmbParse("cmbMtype", q_getPara('uca.mtype'), 's');
				q_gt('uccga', '', 0, 0, 0, "");
				q_gt('uccgb', '', 0, 0, 0, "");
				
				$('#btnUploadimg').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("uploadimg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uploadimg', "680px", "650px", q_getMsg('btnUploadimg'));
				});
				
				$('#btnUcctd').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucctd_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucctd', "680px", "650px", q_getMsg('btnUcctd'));
				});
				
				$('#btnUcap').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucap_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucap', "860px", "706px", q_getMsg('btnUcap'));
				});
				/*$('#btnUcam').click(function() {
				 t_where = "noa='" + $('#txtNoa').val() + "'";
				 q_box("ucam_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucam', "860px", "706px", q_getMsg('btnUcam'));
				 });*/
				$('#btnCheck_div_assm').click(function() {
					//寫入到對應的assm
					var bbt_b_seq = $('#bbt_b_seq').val();
					var tmpassm = '';
					for (var i = 0; i < assm_row; i++) {
						if (dec($('#assm_txtMount_' + i).val()) > 0)
							tmpassm += ($('#assm_txtProductno_' + i).val() + ',' + $('#assm_txtMount_' + i).val() + ';');
					}
					//if(tmpassm.length>0){
					tmpassm = tmpassm.substr(0, tmpassm.length - 1);
					$('#txtAssm__' + bbt_b_seq).val(tmpassm);
					//}
					$('#div_assm').toggle();
				});
				
				$('#btnClose_div_assm').click(function() {
					$('#div_assm').toggle();
				});
				//上方插入空白行
				$('#lblTop_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 0);
					}
				});
				//下方插入空白行
				$('#lblDown_row').mousedown(function(e) {
					if (e.button == 0) {
						q_bbs_addrow(row_bbsbbt, row_b_seq, 1);
					}
				});
				
				$('#btnCustproduct').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("ucccust.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucccust', "95%", "95%", q_getMsg('btnCustproduct'));
				});
				
				$('#btnModel').click(function(){
					var t_where = "noa='" + $.trim($('#txtNoa').val()) + "'";
					q_box("ucab.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ucab', "95%", "95%", $('#btnModel').val());
				});
				
				$('#txtNoa').change(function(){
					var thisVal = $.trim($(this).val());
					if(thisVal.length > 0){
						var t_where = "where=^^ noa='" + thisVal + "' ^^";
						Lock();
						q_gt('ucaucc', t_where, 0, 0, 0, "checkNoa", r_accy);
					}
				});
				
				$('#txtGroupeno').change(function() {
					productchange();
				});
				$('#txtGroupfno').change(function() {
					productchange();
				});
				$('#txtGroupgno').change(function() {
					productchange();
				});
				$('#txtGrouphno').change(function() {
					productchange();
				});
			}
			var t_td = '';
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case 'td':
						if (q_cur > 0 && q_cur < 3) {
							ret = getb_ret();
							if (ret != null) {
								for (var i = 0; i < ret.length; i++) {
									t_td += ret[i].noa + '.';
								}
								if (t_td.length > 0) {
									t_td = t_td.substr(0, t_td.length - 1);
									$('#txtTd_' + b_seq).val(t_td);
									//判斷替代品是否會造成BOM無窮迴圈
									q_func('qtxt.query.bom', 'bom.txt,bom,' + encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
								}
							}
						}
						break;
					case 'ucab':
						getMolds();
						break;
					case 'uploadimg':
						var t_where = "where=^^noa='" + $('#txtNoa').val() + "'^^";
						q_gt('uca', t_where, 0, 0, 0, "uploadimg_noa", r_accy);
						break;
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			var ucsa_cost = 0;
			function q_gtPost(t_name) {
				switch (t_name) {
					case 'checkNoa':
						var as = _q_appendData("ucaucc", "", true);
						if (as[0] != undefined) {
							alert('物品編號重複!!');
							$('#txtNoa').val('').focus();
						}
						Unlock();
						break;
					case 'uccga':
						var as = _q_appendData("uccga", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								if(q_getPara('sys.project').toUpperCase()!='UJ'){
									t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
								}else{
									t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@'+ as[i].noa + '.' + as[i].namea;
								}
								
							}
							q_cmbParse("cmbGroupano", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupano").val(abbm[q_recno].groupano);
							}
						}
						break;
					case 'uccgb':
						var as = _q_appendData("uccgb", "", true);
						if (as[0] != undefined) {
							var t_item = " @ ";
							for ( i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].namea;
							}
							q_cmbParse("cmbGroupbno", t_item);
							if (abbm[q_recno] != undefined) {
								$("#cmbGroupbno").val(abbm[q_recno].groupbno);
							}
						}
						break;
					case 'msg_stk_all':
						var as = _q_appendData("stkucc", "", true);
						var rowslength = document.getElementById("table_stk").rows.length - 1;
						for (var j = 1; j < rowslength; j++) {
							document.getElementById("table_stk").deleteRow(1);
						}
						var stk_row = 0;
						var stkmount = 0;
						for (var i = 0; i < as.length; i++) {
							//倉庫庫存
							if (dec(as[i].mount) != 0) {
								var tr = document.createElement("tr");
								tr.id = "bbs_" + j;
								tr.innerHTML = "<td id='stk_tdStoreno_" + stk_row + "'><input id='stk_txtStoreno_" + stk_row + "' type='text' class='txt c1' value='" + as[i].storeno + "' disabled='disabled'/></td>";
								tr.innerHTML += "<td id='stk_tdStore_" + stk_row + "'><input id='stk_txtStore_" + stk_row + "' type='text' class='txt c1' value='" + as[i].store + "' disabled='disabled' /></td>";
								tr.innerHTML += "<td id='stk_tdMount_" + stk_row + "'><input id='stk_txtMount_" + stk_row + "' type='text' class='txt c1 num' value='" + as[i].mount + "' disabled='disabled'/></td>";
								var tmp = document.getElementById("stk_close");
								tmp.parentNode.insertBefore(tr, tmp);
								stk_row++;
							}
						}
						$('#div_stk').css('top', $('#div_stkcost').offset().top);
						$('#div_stk').css('left', $('#div_stkcost').offset().left - parseInt($('#div_stk').css('width')));
						$('#div_stk').toggle();
						break;
					case 'uploadimg_noa':
						var as = _q_appendData("uca", "", true);
						if (as[0] != undefined) {
							abbm[q_recno]['images'] = as[0].images;
							$('#txtImages').val(as[0].images);
						}
						$('.images').html('');
						if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
							imagename=$('#txtImages').val().split(';');
							imagename.sort();
							var imagehtml="<table width='1260px'><tr>";
							for (var i=0 ;i<imagename.length;i++){
								if(imagename[i]!='')
									imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
							}
							imagehtml+="</tr></table>";
							$('.images').html(imagehtml);
							
							for (var i=0 ;i<imagename.length;i++){
								$('#images_'+i).click(function() {
									var n = $(this).attr('id').split('_')[1];
									t_where = "noa='" + $('#txtNoa').val() + "'";
									q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
								});
							}
						}
						break;
					case q_name:
						if (q_cur == 4){
							q_Seek_gtPost();
						}
						break;
				}
				if (t_name.substr(0, 9) == 'ucascost_') {
					var as = _q_appendData("costs", "", true);
					if (as[0] != undefined) {
						t_noq = t_name.substr(9, t_name.length);
						ucsa_cost = ucsa_cost + (dec(as[0].price) * dec($('#txtMount_' + t_noq).val()));
					}
					$('#textCosta').val(round(ucsa_cost, 2));
				}
				$('#textCosttotal').val(round(dec($('#textCosta').val()) + dec($('#textCostb').val()) + dec($('#textCostc').val()) + dec($('#textCostd').val()) + dec($('#textCostw').val()) + dec($('#textCostm').val()) + dec($('#textCostp').val()) + dec($('#textCostt').val()), 0));
			}
			
			function btnOk() {
				t_err = '';
				t_err = q_chkEmpField([['txtNoa', q_getMsg('lblNoa')], ['txtProduct', q_getMsg('lblProduct')]]);
				// 檢查空白
				if (t_err.length > 0) {
					alert(t_err);
					return;
				}
				//檢查表身是否存在NOA
				var t_nos=-1;
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtProductno_'+i).val()) && $('#txtProductno_'+i).val()==$('#txtNoa').val()){
						t_nos=i+1;
						break;
					}
				}
				if(t_nos>-1){
					alert('表身第'+t_nos+'項品號禁止與物品編號相同!!');
					return;
				}
				
				
				$('#txtWorker').val(r_name);
				sum();
				//重新設定noq
				for (var i = 0; i < q_bbsCount; i++) {
					if (!emp($('#txtProductno_' + i).val()))
						$('#txtNoq_' + i).val(('000' + (i + 1)).slice(-3));
				}
				for (var i = 0; i < q_bbtCount; i++) {
					if (!emp($('#txtProcessno__' + i).val()))
						$('#txtNoq__' + i).val(('000' + (i + 1)).slice(-3));
				}
				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO"){
					var tstyle=$('#txtStyle').val();
					var tspec=$('#txtBdate').val();
					var tsize1=replaceAll(replaceAll(formatzero(dec($('#txtGroupeno').val()),3,2).toString(),'.',''),',','');
					var tsize2=replaceAll(replaceAll(formatzero(dec($('#txtGroupfno').val()),3,2).toString(),'.',''),',','');
					var tsize3=replaceAll(replaceAll(formatzero(dec($('#txtGroupgno').val()),2,2).toString(),'.',''),',','');
					var tsize4=replaceAll(replaceAll(formatzero(dec($('#txtGrouphno').val()),4,1).toString(),'.',''),',','');
					var tsize5=replaceAll(replaceAll(formatzero(dec($('#txtGroupino').val()),3,2).toString(),'.',''),',','');
					var tsize6=replaceAll(replaceAll(formatzero(dec($('#txtGroupjno').val()),3,2).toString(),'.',''),',','');
					var tsize7=replaceAll(replaceAll(formatzero(dec($('#txtGroupkno').val()),2,2).toString(),'.',''),',','');
					var tsize8=replaceAll(replaceAll(formatzero(dec($('#txtGrouplno').val()),4,1).toString(),'.',''),',','');
					
					q_gtnoa(q_name, replaceAll(tstyle+tsize2+tsize3+tsize6+tsize7, '/', ''));
				}else
					wrServer(s1);
			}
			
			function formatzero(value, num1, num2){//數字,小數前,小數後
			    var a = value.toString();
			    var b = a.indexOf(".");
			    var str1='';
			    var str2='';
			    if(b!=-1){
			    	str1=a.substr(0,b);
			    	str2=a.substr(b+1,a.length);
			    	
			    	if(str1.length<num1){
			    		for (var i = 1; i <= num1; i++) {
							str1 = "0" + str1;
						}
						str1=str1.slice(-1*num1);
			    	}
			    	if(str2.length<num2){
			    		for (var i = 1; i <= num2; i++) {
							str2 =str2 + "0";
						}
						str2=str2.substr(0,num2);
			    	}
			    	return str1+'.'+str2;
			    }else{
			    	if(a.length>=num1){
			    		str1=a;
			    	}else{
				    	for (var i = 1; i <= num1; i++) {
							str1 = str1 + "0";
						}
				    	str1=(str1+a).slice(-1*num1);
			    	}
			    	if(num2>0){
			    		for (var i = 1; i <= num2; i++) {
							str2 = str2 + "0";
						}
			    	}
			    	return str1+(str2.length>0?'.'+str2:'');
			    }
			}
			
			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('uca_s.aspx', q_name + '_s', "500px", "480px", q_getMsg("popSeek"));
			}
			
			function bbsAssign() {
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text(j + 1);
					if (!$('#btnMinus_' + j).hasClass('isAssign')) {
						$('#btnProductno_'+ j).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtProductno_' + b_seq).val()))
								q_box("z_ucap.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtProductno_'+ b_seq).val() + "' and product='" + $('#txtProduct_'+ b_seq).val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
						});
						
						$('#txtProductno_' + j).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
							}
							if (!emp($('#txtProductno_' + b_seq).val()) && !emp($('#txtNoa').val()))
								q_func('qtxt.query.bom', 'bom.txt,bom,' + encodeURI($('#txtProductno_' + b_seq).val()) + ';' + encodeURI($('#txtNoa').val()));
						});
						$('#btnTproductno_' + j).click(function() {
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
								return;
							}
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#text_Noq').val(b_seq);
							q_box("ucc_b2.aspx", 'td', "95%", "650px", q_getMsg('popTd'));
						});
						$('#txtTd_' + j).focusin(function() {
							if (emp($('#txtNoa').val())) {
								alert('請先輸入【' + q_getMsg('lblNoa') + '】');
								$('#txtNoa').focus();
								return;
							} else {
								q_msg($(this), '輸入格式為：品號.品號.品號........');
							}
						}).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if (!emp($('#txtTd_' + b_seq).val())) {
								if ($('#txtTd_' + b_seq).val().indexOf(';') > 0 || $('#txtTd_' + b_seq).val().indexOf(',') > 0) {
									$('#txtTd_' + b_seq).val(replaceAll($('#txtTd_' + b_seq).val(), ',', '.'));
									$('#txtTd_' + b_seq).val(replaceAll($('#txtTd_' + b_seq).val(), ';', '.'));
								}
								t_td = $('#txtTd_' + b_seq).val();
								//判斷替代品是否會造成BOM無窮迴圈
								q_func('qtxt.query.bom', 'bom.txt,bom,' + encodeURI(t_td) + ';' + encodeURI($('#txtNoa').val()));
							}
						});
						$('#btnMinus_'+j).bind('contextmenu',function(e) {
							e.preventDefault();
	                    	if(e.button==2){
								////////////控制顯示位置
								$('#div_row').css('top', e.pageY);
								$('#div_row').css('left', e.pageX);
								//////////////
								t_IdSeq = -1;
								q_bodyId($(this).attr('id'));
								b_seq = t_IdSeq;
								$('#div_row').show();
								//顯示選單
								row_b_seq = b_seq;
								//儲存選取的row
								row_bbsbbt = 'bbs';
								//儲存要新增的地方
							}
                    	});
						
					}
				}
				_bbsAssign();
			}
			
			var assm_row = 0;
			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						
					}
				}
				_bbtAssign();
				
				$('.assmt').each(function(index) {
					$(this).unbind('change');
					$(this).change(function() {
						var n=$(this).attr('id').split('__')[1];
						var t_assm='';
						for(var k=1;k<=13;k++){
							t_assm=t_assm+'@,#'+$('#textAssm'+k+'__'+n).val();
						}
						
						$('#txtAssm__'+n).val(t_assm);
					});
				});
				splitbbtf();
			}
			
			function splitbbtf(){ //拆解bbt欄位
				for (var i = 0; i < q_bbtCount; i++) {
					//合併儲存
					var tstr=$('#txtAssm__'+i).val().split('@,#');
					if(tstr.length>1){
						for(var k=1;k<=13;k++){
							$('#textAssm'+k+'__'+i).val(tstr[k]);
						}
					}
				}
			}
			
			function q_funcPost(t_func, result) {
				switch(t_func) {
					case 'qtxt.query.bom':
						var as = _q_appendData("tmp0", "", true, true);
						if (as[0] == undefined) {
							if (t_td.length > 0) {
								alert('替代品會造成BOM錯誤!!請重新填入!!');
								$('#txtTd_' + b_seq).val('');
							} else {
								alert('BOM錯誤!!該品號不能填入!!');
								$('#btnMinus_' + b_seq).click();
							}
						}
						t_td = '';
						break;
				}
			}
			
			function btnIns() {
				if ($('#Copy').is(':checked')) {
					curData.copy();
				}
				_btnIns();
				if ($('#Copy').is(':checked')) {
					curData.paste();
				}
				$('#txtKdate').val(q_date());
				$('#txtWdate').val('');
				$('#txtProduct').focus();
				$('#txtRev').val('001');
				$('#txtNoa').val('AUTO');
				
				refreshBbm();
			}
			
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtWdate').val(q_date());
				$('#txtProduct').focus();
				
				refreshBbm();
			}
			
			function btnPrint() {
				q_box("z_ucap.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='" + $('#txtNoa').val() + "' and product='" + $('#txtProduct').val() + "';" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
			}
			
			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
				t_err = '';
				if (!as['productno'] && !as['product']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				as['noa'] = abbm2['noa'];
				as['rev'] = abbm2['rev'];
				if (t_err) {
					alert(t_err);
					return false;
				}
				return true;
			}
			
			function bbtSave(as) {
                if (!as['processno'] && !as['process'] && !as['tggno'] && !as['stationno'] && !as['productno'] && !as['assm']) {
                    as[bbtKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }
            
            function q_popPost(s1) {
			   	switch (s1) {
			   		case 'txtBdate':
			   			productchange();
			   			break;
			   		case 'txtStyle':
			   			productchange();
			   			break;
			   	}
			}
			
			function sum() {
			}
			
			function productchange(){
				var t_style=$('#txtTeam').val();
				var t_spec=$('#txtSize').val();
				var t_size1=$('#txtGroupeno').val();
				var t_size2=$('#txtGroupfno').val();
				var t_size3=$('#txtGroupgno').val();
				var t_size4=$('#txtGrouphno').val();
				var t_size=t_size1;
				if(t_size2.length>0){
					t_size=t_size+(t_size.length>0?'x':'')+t_size2;
				}
				if(t_size3.length>0){
					t_size=t_size+(t_size.length>0?'x':'')+t_size3;
				}
				if(t_size4.length>0){
					t_size=t_size+(t_size.length>0?'x':'')+t_size4;
				}
				
				var t_product=t_style;
				if(t_spec.length>0){
					t_product=t_product+(t_product.length>0?' ':'')+t_spec;
				}
				if(t_size.length>0){
					t_product=t_product+(t_product.length>0?' ':'')+t_size;
				}
				$('#txtProduct').val(t_product);
			}
			
			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				$('#div_stk').hide();
				$('#div_stkcost').hide();
				//format();
				$('.images').html('');
				if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
					imagename=$('#txtImages').val().split(';');
					imagename.sort();
					var imagehtml="<table width='1260px'><tr>";
					for (var i=0 ;i<imagename.length;i++){
						if(imagename[i]!='')
							imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
					}
					imagehtml+="</tr></table>";
					$('.images').html(imagehtml);
					
					for (var i=0 ;i<imagename.length;i++){
						$('#images_'+i).click(function() {
							var n = $(this).attr('id').split('_')[1];
							t_where = "noa='" + $('#txtNoa').val() + "'";
							q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
						});
					}
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if (t_para) {
					$('#div_row').hide();
					$('#div_assm').hide();
					//恢復滑鼠右鍵
					/*document.oncontextmenu = function() {
						return true;
					}*/
				} else {
					//防滑鼠右鍵
					/*document.oncontextmenu = function() {
						return false;
					}*/
				}
			}
			
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
			
			function btnMinus(id) {
				_btnMinus(id);
				sum();
			}
			
			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
			
			function q_appendData(t_Table) {
				dataErr = !_q_appendData(t_Table);
			}
			
			function btnSeek() {
				_btnSeek();
			}
			
			function btnTop() {
				_btnTop();
			}
			
			function btnPrev() {
				_btnPrev();
			}
			
			function btnPrevPage() {
				_btnPrevPage();
			}
			
			function btnNext() {
				_btnNext();
			}
			
			function btnNextPage() {
				_btnNextPage();
			}
			
			function btnBott() {
				_btnBott();
			}
			
			function q_brwAssign(s1) {
				_q_brwAssign(s1);
			}
			
			function btnDele() {
				_btnDele();
			}
			
			function btnCancel() {
				_btnCancel();
			}
			//輸入數字判斷
			function ValidateFloat(e, pnumber) {
				if (!/^\d+[.]?\d*$/.test(pnumber)) {
					$(e).val(/^\d+[.]?\d*/.exec($(e).val()));
				}
				return false;
			}
			var mouse_div = true;
			//控制滑鼠消失div
			var row_bbsbbt = '';
			//判斷是bbs或bbt增加欄位
			var row_b_seq = '';
			//判斷第幾個row
			//插入欄位
			function q_bbs_addrow(bbsbbt, row, topdown) {
				//取得目前行
				var rows_b_seq = dec(row) + dec(topdown);
				if (bbsbbt == 'bbs') {
					q_gridAddRow(bbsHtm, 'tbbs', 'txtNoq', 1);
					//目前行的資料往下移動
					for (var i = q_bbsCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbs.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbs[j] + '_' + i).val($('#' + fbbs[j] + '_' + (i - 1)).val());
							else
								$('#' + fbbs[j] + '_' + i).val('');
						}
					}
				}
				if (bbsbbt == 'bbt') {
					q_gridAddRow(bbtHtm, 'tbbt', fbbt, 1, '', '', '', '__');
					//目前行的資料往下移動
					for (var i = q_bbtCount - 1; i >= rows_b_seq; i--) {
						for (var j = 0; j < fbbt.length; j++) {
							if (i != rows_b_seq)
								$('#' + fbbt[j] + '__' + i).val($('#' + fbbt[j] + '__' + (i - 1)).val());
							else
								$('#' + fbbt[j] + '__' + i).val('');
						}
					}
				}
				$('#div_row').hide();
				row_bbsbbt = '';
				row_b_seq = '';
			}
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 30%;
			}
			.tview {
				margin: 0;
				padding: 2px;
				border: 1px black double;
				border-spacing: 0;
				font-size: medium;
				background-color: #FFFF66;
				color: blue;
				width: 100%;
			}
			.tview td {
				padding: 2px;
				/*text-align: center;*/
				border: 1px black solid;
			}
			.dbbm {
				float: left;
				width: 68%;
				margin: -1px;
				border: 1px black solid;
				border-radius: 5px;
			}
			.tbbm {
				padding: 0px;
				border: 1px white double;
				border-spacing: 0;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.tbbm tr {
				height: 35px;
			}
			.tbbm tr td {
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				width: 2%;
			}
			.tbbm tr td span {
				float: right;
				display: block;
				width: 5px;
				height: 10px;
			}
			.tbbm tr td .lbl {
				float: right;
				color: blue;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn {
				color: #4297D7;
				font-weight: bolder;
				font-size: medium;
			}
			.tbbm tr td .lbl.btn:hover {
				color: #FF8F19;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c5 {
				width: 75%;
				float: left;
			}
			.tbbm td {
				margin: 0 -1px;
				padding: 0;
			}
			.tbbm td input[type="text"] {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				float: left;
			}
			.tbbm td input[type="button"] {
				/*float: left;*/
				width: auto;
			}
			.tbbm select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			.tbbs a {
				font-size: medium;
			}
			.tbbs tr.error input[type="text"] {
				color: red;
			}
			.tbbs {
				FONT-SIZE: medium;
				COLOR: blue;
				TEXT-ALIGN: left;
				BORDER: 1PX LIGHTGREY SOLID;
				width: 100%;
				height: 98%;
			}
			.num {
				text-align: right;
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 1755px;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
			#div_assm {
				display: none;
				width: 750px;
				background-color: #FFAC55;
				border: 5px solid gray;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			#div_assm .tdY {
				width: 98%;
			}
			#div_row {
				display: none;
				width: 750px;
				background-color: #ffffff;
				position: absolute;
				left: 20px;
				z-index: 50;
			}
			.table_row tr td .lbl.btn {
				color: #000000;
				font-weight: bolder;
				font-size: medium;
				cursor: pointer;
			}
			.table_row tr td .lbl.btn:hover {
				color: #FF8F19;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div id="div_row" style="position:absolute; top:300px; left:500px; display:none; width:150px; background-color: #ffffff; ">
			<table id="table_row" class="table_row" style="width:100%;" border="1" cellpadding='1' cellspacing='0'>
				<tr>
					<td align="center" ><a id="lblTop_row" class="lbl btn">上方插入空白行</a></td>
				</tr>
				<tr>
					<td align="center" ><a id="lblDown_row" class="lbl btn">下方插入空白行</a></td>
				</tr>
			</table>
		</div>
		<div id="div_assm" style="position:absolute; top:300px; left:500px; display:none; width:500px; background-color: #FFAC55; border: 5px solid gray;">
			<table id="table_assm" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<tr id='assm_top'>
					<td align="center" style="width: 40%;">品號 </td>
					<td align="center" style="width: 45%;">品名</td>
					<td align="center" style="width: 15%;">數量</td>
				</tr>
				<tr id='assm_close'>
					<td align="center" colspan='3'>
					<input id="btnCheck_div_assm" type="button" value="確認">
					<input id="btnClose_div_assm" type="button" value="關閉視窗">
					<input id="bbt_b_seq" type="hidden"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="div_stk" style="position:absolute; top:300px; left:400px; display:none; width:400px; background-color: #CDFFCE;">
			<table id="table_stk" style="width:100%;" border="1" cellpadding='2' cellspacing='0'>
				<!--<tr>
				<td style="background-color: #f8d463;" align="center">產品編號</td>
				<td style="background-color: #f8d463;" colspan="2" id='stk_productno'> </td>
				</tr>
				<tr>
				<td style="background-color: #f8d463;" align="center">產品名稱</td>
				<td style="background-color: #f8d463;" colspan="2" id='stk_product'> </td>
				</tr>-->
				<tr id='stk_top'>
					<td align="center" style="width: 30%;">倉庫編號</td>
					<td align="center" style="width: 45%;">倉庫名稱</td>
					<td align="center" style="width: 25%;">倉庫數量</td>
				</tr>
				<tr id='stk_close'>
					<td align="center" colspan='3'>
					<input id="btnClose_div_stk" type="button" value="關閉視窗">
					</td>
				</tr>
			</table>
		</div>
		<div id='dmain' style="overflow:hidden; width: 1260px;">
			<!--#include file="../inc/toolbar.inc"-->
			<div class="dview" id="dview" style="float: left; width:400px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:40px"><a id='vewChk'> </a></td>
						<td align="center" style="width:170px"><a id='vewNoa'> </a></td>
						<td align="center" style="width:190px"><a id='vewProduct'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='noa'>~noa</td>
						<td id='product spec'>~product ~spec</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='0' >
					<tr style="height:1px;">
						<td style="width:100px;"> </td>
						<td style="width:200px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:220px;"> </td>
						<td style="width:100px;"> </td>
						<td style="width:130px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblKdate" class="lbl"> </a></td>
						<td>
							<input id="txtKdate" type="text" class="txt" style="width:65%;"/>
							<div style="float:left;">
								<input id="Copy" type="checkbox" />
								<span> </span><a id="lblCopy"> </a>
							</div>
						</td>
						<td><span> </span><a id="lblWdate" class="lbl"> </a></td>
						<td><input id="txtWdate" type="text" class="txt"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan='2'><input id="txtProduct" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblEngpro" class="lbl"> </a></td>
						<td colspan='2'><input id="txtEngpro" type="text" class="txt c1"/></td>
						<td style="display: none;"><span> </span><a id="lblType" class="lbl"> </a></td>
						<td style="display: none;"><select id="cmbTypea" class="txt c1" style="font-size: medium;"> </select></td>
						<td style="display: none;"><input id="btnCustproduct" type="button" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStyle_na" class="lbl btn">型</a></td>
						<td>
							<input id="txtStyle" type="text" class="txt" style="width: 45%;"/>
							<input id="txtTeam" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td>
							<input id="txtCustno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtCust" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblUweight" class="lbl"> </a></td>
						<td><input id="txtUweight" type="text" class="txt c1 num"/></td>
						<!--<td><span> </span><a id="lblUnit" class="lbl"> </a></td>
						<td><input id="txtUnit" type="text" class="txt c1"/></td>-->
					</tr>
					<tr>
						<td><span> </span><a id="lblBdate_na" class="lbl">成品材質</a></td>
						<td>
							<input id="txtBdate" type="text" class="txt c1" style="width:40%;"/>
							<input id="txtSize" type="text" class="txt c1" style="width:45%;"/>
						</td>
						<td><span> </span><a id="lblGroupeno_na" class="lbl" >短徑</a></td>
						<td><input id="txtGroupeno" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblGroupfno_na" class="lbl" style="float: left;">長徑</a>
							<span style="float: left;"> </span>
							<input id="txtGroupfno" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
						<td><span> </span><a id="lblGroupgno_na" class="lbl" >厚度</a></td>
						<td><input id="txtGroupgno" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblGrouphno_na" class="lbl" style="float: left;">長度</a>
							<span style="float: left;"> </span>
							<input id="txtGrouphno" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEdate_na" class="lbl">素材材質</a></td>
						<td>
							<input id="txtEdate" type="text" class="txt c1" style="width:40%;"/>
							<input id="txtEngprono" type="text" class="txt c1" style="width:45%;"/>
						</td>
						<td><span> </span><a id="lblGroupino_na" class="lbl" >短徑</a></td>
						<td><input id="txtGroupino" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblGroupjno_na" class="lbl" style="float: left;">長徑</a>
							<span style="float: left;"> </span>
							<input id="txtGroupjno" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
						<td><span> </span><a id="lblGroupkno_na" class="lbl" >厚度</a></td>
						<td><input id="txtGroupkno" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;margin-left: 15px;"> </span>
							<a id="lblGrouplno_na" class="lbl" style="float: left;">長度</a>
							<span style="float: left;"> </span>
							<input id="txtGrouplno" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblGroupano" class="lbl"> </a></td>
						<td>
							<select id="cmbGroupano" class="txt" style="font-size: medium;width: 55%;"> </select>
							<select id="cmbGroupbno" class="txt isUJ" style="font-size: medium;width: 45%;display: none;"> </select>
						</td>
						<td><span> </span><a id="lblTgg" class="lbl btn"> </a></td>
						<td>
							<input id="txtTggno" type="text" class="txt" style="width: 45%;"/>
							<input id="txtComp" type="text" class="txt" style="width: 53%;"/>
						</td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblStdmount" class="lbl" > </a></td>
						<td><input id="txtStdmount" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;"> </span>
							<a id="lblSafemount" class="lbl" style="float: left;"> </a>
							<span style="float: left;"> </span>
							<input id="txtSafemount" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id="lblHours" class="lbl"> </a></td>
						<td>
							<input id="txtHours" type="text" class="txt num" style="display: none;"/>
							<span style="float:left;width:15%;padding-left:3px;display: none;">Hr.</span>
							<input id="txtMinutes" type="text" class="txt num c1" style="width: 30%;"/>
							<span style="float:left;width:15%;padding-left:3px;">Min.</span>
							<input id="txtSec" type="text" class="txt num c1" style="width: 30%;"/>
							<span style="float:left;width:15%;padding-left:3px;">Sec.</span>
						</td>
						
						<td><span> </span><a id="lblPreday" class="lbl"> </a></td>
						<td>
							<input id="txtPreday" type="text" class="txt c1 num" style="width:30%;"/>
							<span style="float: left;"> </span>
							<a id="lblBadperc" class="lbl" style="float: left;"> </a>
							<span style="float: left;"> </span>
							<input id="txtBadperc" type="text" class="txt c1 num" style="width:30%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo_na" class="lbl">特殊要求</a></td>
						<td colspan='3'>
							<input id="txtMemo" type="text" class="txt c1" style="width: 99%;"/>
							<input type="hidden" id="txtImages" class="txt c1"/>
						</td>
						<!--<td><span> </span><a id="lblRev" class="lbl"> </a></td>
						<td><input id="txtRev" type="text" class="txt c1" style="width: 30%;"/></td>-->
						<td> </td>
						<td><input id="btnUploadimg" type="button"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMakes" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtMakes" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblPacks" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtPacks" type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblWages" class="lbl" style="font-size: 14px;"> </a></td>
						<td><input id="txtWages" type="text" class="txt c1 num"/></td>
					</tr>
					<input id="text_Noq" type="hidden" />
				</table>
			</div>
		</div>
		<div class='dbbs' style="width: 1350px;display: none;">
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1' >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:40px;">
						<input class="btn" id="btnPlus" type="button" value='＋' style="font-weight: bold;" />
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:200px;"><a id='lblProductno'> </a></td>
					<td align="center" style="width:260px;"><a id='lblProducts'> </a></td>
					<td align="center" style="width:40px;"><a id='lblUnit_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblMount'> </a></td>
					<!--<td align="center" style="width:8%;"><a id='lblWeights'></a></td>-->
					<td align="center" style="width:120px;"><a id='lblMtype_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblProcessno_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblLoss_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblDividea_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblMul_s'> </a></td>
					<!--<td align="center" style="width:15%;"><a id='lblTd'></a></td>-->
					<td align="center" style="width:200px;"><a id='lblMemos'> </a></td>
				</tr>
				<tr style='background:#cad3ff;'>
					<td><input class="btn" id="btnMinus.*" type="button" value='－' style=" font-weight: bold;" /></td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
						<input class="btn" id="btnProductno.*" type="button" value='.' style=" font-weight: bold;float: left;" />
						<input id="txtProductno.*" type="text" class="txt c1" style="width: 85%;"/>
					</td>
					<td>
						<input id="txtProduct.*" type="text" class="txt c1"/>
						<input id="txtSpec.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtUnit.*" type="text" class="txt c1" style="text-align:center;"/></td>
					<td><input id="txtMount.*" type="text" class="txt num c1"/></td>
					<!--<td><input id="txtWeight.*" type="text" class="txt num c1"/></td>-->
					<td><select id="cmbMtype.*" class="txt c1"> </select></td>
					<td>
						<input class="btn" id="btnProcessno.*" type="button" value='.' style=" font-weight: bold;" />
						<input id="txtProcessno.*" type="text" style="width: 75%;"/>
						<input id="txtProcess.*" type="text" class="txt c1"/>
					</td>
					<td><input id="txtLoss.*" type="text" class="txt num c1"/></td>
					<td><input id="txtDividea.*" type="text" class="txt num c1"/></td>
					<td><input id="txtMul.*" type="text" class="txt num c1"/></td>
					<!--<td>
					<input class="btn" id="btnTproductno.*" type="button" value='.' style=" font-weight: bold;" />
					<input id="txtTd.*" type="text" style="width: 80%;"/>
					</td>-->
					<td>
						<input id="txtMemo.*" type="text" class="txt c1"/>
						<input id="txtNoq.*" type="hidden" />
						<input id="recno.*" type="hidden" />
					</td>
				</tr>
			</table>
		</div>
		<div id="dbbt" >
			<table id="tbbt" class='tbbt' border="1" cellpadding='2' cellspacing='1'>
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:40px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td align="center" style="width:145px;display: none;"><a id='lblProcess_t'> </a></td>
					<td align="center" style="width:145px;"><a id='lblStation_na_t'>製程</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm1_na_t'>製程備註1</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm2_na_t'>製程備註2</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm3_na_t'>製程備註3</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm4_na_t'>製程備註4</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm5_na_t'>製程備註5</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm6_na_t'>製程備註6</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm7_na_t'>製程備註7</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm8_na_t'>製程備註8</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm9_na_t'>製程備註9</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm10_na_t'>製程備註10</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm11_na_t'>製程備註11</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm12_na_t'>製程備註12</a></td>
					<td align="center" style="width:60px;"><a id='lblAssm13_na_t'>製程備註13</a></td>
					<td align="center" style="width:145px;"><a id='lblTgg_t'> </a></td>
					<td align="center" style="width:100px;"><a id='lblPrice_t'> </a></td>
				</tr>
				<tr>
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="hidden"/>
						<input class="txt" id="txtAssm..*" type="hidden"/>
					</td>
					<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="display: none;">
						<input id="txtProcessno..*" type="text" class="txt c1" style="width: 30%;"/>
						<input id="btnProcessno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtProcess..*" type="text" class="txt c1"  style="width: 50%;"/>
					</td>
					<td>
						<input id="txtStationno..*" type="text" class="txt c1" style="width: 30%;"/>
						<input id="btnStation..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtStation..*" type="text" class="txt c1" style="width: 50%;"/>
					</td>
					<td><input id="textAssm1..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm2..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm3..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm4..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm5..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm6..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm7..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm8..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm9..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm10..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm11..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm12..*" type="text" class="txt c1 assmt"/></td>
					<td><input id="textAssm13..*" type="text" class="txt c1 assmt"/></td>
					<td>
						<input id="txtTggno..*" type="text" class="txt c1" style="width: 30%;"/>
						<input id="btnTggno..*" type="button" value='.' style=" font-weight: bold;width:1%;" />
						<input id="txtNick..*" type="text" class="txt c1" style="width: 50%;"/>
					</td>
					<td><input id="txtPrice..*" type="text" class="txt c1 num"/></td>
				</tr>
			</table>
		</div>
		<div class='images' style="float: left;"> </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>