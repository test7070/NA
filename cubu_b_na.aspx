<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = 'cubu', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = 'cubu';
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var Parent = window.parent;
			var cubBBtArray = '';
			if (Parent.q_name && Parent.q_name == 'cub') {
				cubBBtArray = Parent.abbtNow;
			}
			aPop = new Array(
				['txtStoreno_', 'btnStoreno_', 'store', 'noa,store', 'txtStoreno_,txtStore_', 'store_b.aspx'],
				['txtUcolor_', 'btnProduct_', 'uca', 'noa,style,team,bdate,size,groupeno,groupfno,groupgno,grouphno', 'txtUcolor_,txtStyle_,txtProduct_,txtProductno_,txtScolor_,txtRadius_,txtWidth_,txtDime_,txtLengthb_', 'uca_b.aspx'],
				['txtProductno_', 'btnProduct2_', 'ucc', 'noa,product', 'txtProductno_,txtScolor_', 'ucc_b.aspx'],
				['txtStyle_', 'btnStyle_', 'style', 'noa,product', 'txtStyle_,txtProduct_', 'style_b.aspx']
			);
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				q_gt('style', '', 0, 0, 0, '');
				main();
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
				$('#btnTop').hide();
				$('#btnPrev').hide();
				$('#btnNext').hide();
				$('#btnBott').hide();
			}

			function mainPost() {
				bbmMask = [];
				bbsMask = [['txtDatea', r_picd]];
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
				
				$('#btnCubt').click(function() {
					var t_key = q_getHref();
					var t_noa=t_key[1];
					
					if(q_cur==1 || q_cur==2){
						var t_ucolor=Parent.$('#txtProductno').val();
						var t_style=Parent.$('#txtM7').val();
						var t_product=Parent.$('#txtProduct').val();
						var t_spec=Parent.$('#txtSpec').val();
						var t_productno=Parent.$('#txtM1').val();
						var t_scolor=Parent.$('#txtM2').val();
						var t_radius=Parent.$('#txtM3').val();
						var t_widths=Parent.$('#txtM4').val();
						var t_dime=Parent.$('#txtM5').val();
						var t_lengthb=Parent.$('#txtM6').val();
						var t_mount=dec(Parent.$('#txtMount').val());
						var t_weight=dec(Parent.$('#txtIdime').val());
						var t_datea=q_date();
						
						for (var j = 0; j < q_bbsCount; j++) {
							$('#btnMinus_'+j).click();
						}
						
						while(q_bbsCount<cubBBtArray.length){
							$('#btnPlus').click();
						}
						
						var tgcount=0;
						for (var j=0 ;j<cubBBtArray.length;j++){
							tgcount=q_add(tgcount,dec(cubBBtArray[j].gmount));
						}
						if(tgcount>0 && t_productno.length>0){
							for (var j=0 ;j<cubBBtArray.length;j++){
								var tgmount=dec(cubBBtArray[j].gmount);
								var tuno=cubBBtArray[j].uno;
								if(tuno.length>0){
									var t_mxuno='';
									q_gt('view_uccb', "where=^^ uno=(select MAX(uno) from view_uccb where uno like '"+tuno+"-%' and noa!='"+t_noa+"') ^^", 0, 0, 0, "getuno",r_accy,1);
									var as = _q_appendData("view_uccb", "", true);
									if(as[0]!=undefined){
										t_mxuno=as[0].uno;	
									}
									//檢查表身是否已被指定
									for (var n = 0; n < q_bbsCount; n++) {
										if($('#txtUno_'+n).val().indexOf(tuno+'-')>-1 && $('#txtUno_'+n).val()>t_mxuno){
											t_mxuno=$('#txtUno_'+n).val();
										}
									}
									if(t_mxuno.length>0){
										var t_num=dec(t_mxuno.substr(t_mxuno.indexOf('-')+1));
										t_num++;
										$('#txtUno_'+j).val(tuno+'-'+('00'+t_num.toString()).slice(-2));
									}else{
										$('#txtUno_'+j).val(tuno+'-01');
									}
								}else if (tuno.length==0 && tgmount!=0){
									q_func('qtxt.query.getuno_bydate', 'uno.txt,getuno_bydate,'+ encodeURI(replaceAll(t_datea,'/',''))+';'+encodeURI('#non')+';'+encodeURI('#non')+';'+encodeURI('#non'),r_accy,1);
									var as = _q_appendData("tmp0", "", true, true);
									if (as[0] != undefined) {
										$('#txtUno_'+j).val(as[0].uno);
									}
								}
								$('#txtUcolor_'+j).val(t_ucolor);
								$('#txtStyle_'+j).val(t_style);
								$('#txtProduct_'+j).val(t_product);
								$('#txtSpec_'+j).val(t_spec);
								$('#txtProductno_'+j).val(t_productno);
								$('#txtScolor_'+j).val(t_scolor);
								$('#txtRadius_'+j).val(t_radius);
								$('#txtWidth_'+j).val(t_widths);
								$('#txtDime_'+j).val(t_dime);
								$('#txtLengthb_'+j).val(t_lengthb);
								$('#txtMount_'+j).val(round(q_mul(t_mount,q_div(tgmount,tgcount)),0));
								$('#txtWeight_'+j).val(round(q_mul(t_weight,q_div(tgmount,tgcount)),2));
								$('#txtDatea_'+j).val(t_datea);
							}
						}
					}
				});
			}

			function getTheory(b_seq) {
                t_Radius = dec($('#txtRadius_' + b_seq).val());
                t_Width = dec($('#txtWidth_' + b_seq).val());
                t_Dime = dec($('#txtDime_' + b_seq).val());
                t_Lengthb = dec($('#txtLengthb_' + b_seq).val());
                t_Mount = dec($('#txtMount_' + b_seq).val());
                t_Style = $('#txtStyle_' + b_seq).val();
                t_Stype = ($('#cmbStype').find("option:selected").text() == '外銷' ? 1 : 0);
                t_Productno = $('#txtProductno_' + b_seq).val();
                var theory_setting={
                    calc:StyleList,
                    ucc:t_uccArray,
                    radius:t_Radius,
                    width:t_Width,
                    dime:t_Dime,
                    lengthb:t_Lengthb,
                    mount:t_Mount,
                    style:t_Style,
                    stype:t_Stype,
                    productno:t_Productno,
                    round:1
                };
                
                q_tr('txtWeight_' + b_seq, theory_st(theory_setting));
            }

			var toFocusOrdeno = 0;
			function bbsAssign() {
				_bbsAssign();
				SetBBsReadonly(ReadOnlyUno);
				for (var j = 0; j < q_bbsCount; j++) {
					$('#lblNo_' + j).text((j + 1));

					$('#txtStyle_' + j).blur(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					
					$('#txtRadius_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtWidth_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtDime_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtLengthb_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					$('#txtWeight_' + j).change(function() {
						TotWeight();
					});
					$('#txtMount_' + j).change(function() {
						var n = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
						getTheory(n);
					});
					
				}
			}

			function btnOk() {
				TotWeight();
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}

			function bbsSave(as) {
				if (!as['uno'] && !as['productno']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
				SetBBsReadonly(ReadOnlyUno);
				$('#btnOk').before($('#btnOk').clone().attr('id', 'btnOk2').show()).hide();
				$('#btnOk2').click(function() {
					var t_errMsg = '';
					for (var i = 0; i < q_bbsCount; i++) {
						$('#txtWorker_' + i).val(r_name);
						var t_datea = trim($('#txtDatea_' + i).val());
						var t_uno = trim($('#txtUno_' + i).val());
						var t_mount = dec($('#txtMount_' + i).val());
						var t_weight = dec($('#txtWeight_' + i).val());
						if (t_datea.length != 9) {
							if ($.trim(Parent.$('#txtDatea').val()) != '')
								$('#txtDatea_' + i).val($.trim(Parent.$('#txtDatea').val()));
							else
								$('#txtDatea_' + i).val(q_date());
						}
						//不存檔提示!!
						if ((t_mount > 0) && (t_weight <= 0))
							t_errMsg += '第 ' + (i + 1) + " 筆重量小於等於0。\n";
						if ((t_mount > 0) && (t_uno.length == 0))
							t_errMsg += '第 ' + (i + 1) + " 筆批號為空。\n";
					}
					if ($.trim(t_errMsg).length > 0) {
						alert(t_errMsg);
						return;
					}
					//檢查批號
                    for (var i = 0; i < q_bbsCount; i++) {
                        for (var j = i + 1; j < q_bbsCount; j++) {
                            if ($.trim($('#txtUno_' + i).val()).length > 0 && $.trim($('#txtUno_' + i).val()) == $.trim($('#txtUno_' + j).val())) {
                                alert('【' + $.trim($('#txtUno_' + i).val()) + '】' + q_getMsg('lblUno_st') + '重覆。\n' + (i + 1) + ', ' + (j + 1));
                                Unlock(1);
                                return;
                            }
                        }
                    }
                    //parent.$('#txtNoa').val()
                    var t_where = '';
                    for (var i = 0; i < q_bbsCount; i++) {
                        if ($.trim($('#txtUno_' + i).val()).length > 0)
                            t_where += (t_where.length > 0 ? ' or ' : '') + "(uno='" + $.trim($('#txtUno_' + i).val()) + "' and not(tablea='cubu' and noa='" + $.trim($('#txtNoa_'+i).val()) + "'))";
                    }
                    if (t_where.length > 0)
                        q_gt('view_uccb', "where=^^" + t_where + "^^", 0, 0, 0, 'btnOk_checkuno');
                    else{
                        qbtnOk();
                        parent.$.fn.colorbox.close();
                    }
				});
			}

			function SetBBsReadonly(UnoArr) {
				for (var j = 0; j < UnoArr.length; j++) {
					var thisUno = $.trim(UnoArr[j]);
					for (var k = 0; k < q_bbsCount; k++) {
						var bbsUno = $.trim($('#txtUno_' + k).val());
						if (thisUno == bbsUno) {
							$('#btnMinus_' + k).attr('disabled', 'disabled');
							$('#txtUno_' + k).attr('readonly', true).css({
								'color' : t_color2,
								'background' : t_background2
							});
						}
					}
				}
			}

			function GetBBsUno() {
				var ReturnStr = '';
				var TmpArr = [];
				for (var i = 0; i < q_bbsCount; i++) {
					var thisVal = $.trim($('#txtUno_' + i).val());
					if (thisVal.length > 0) {
						TmpArr.push(thisVal);
					}
				}
				if (TmpArr.length > 0) {
					ReturnStr = "'" + TmpArr.toString().replace(/\,/g, "','") + "'";
					return ReturnStr;
				} else {
					return '';
				}
			}

			function refresh() {
				_refresh();
				$('input[id*="txtProduct_"]').each(function() {
					thisId = $(this).attr('id').split('_')[$(this).attr('id').split('_').length - 1];
					$(this).attr('OldValue', $('#txtUcolor_' + thisId).val());
				});
				var UnoList = $.trim(GetBBsUno());
				if (UnoList.length > 0) {
					var t_where = 'where=^^ (1=1) and (uno in(' + UnoList + '))^^';
					q_gt('uccy', t_where, 0, 0, 0, 'deleUccy', r_accy);
				}
				TotWeight();
			}
			function TotWeight(){
				var totWeight = 0;
				for(var i=0;i<q_bbsCount;i++){
					totWeight = q_add(totWeight,q_float('txtWeight_'+i));
				}
				$('#totWeight').text(totWeight);
			}

			var StyleList = '';
			var t_uccArray = new Array;
			var ReadOnlyUno = [];
			function q_gtPost(t_postname) {
				switch (t_postname) {
				    case 'btnOk_checkuno':
                        var as = _q_appendData("view_uccb", "", true);
                        if (as[0] != undefined) {
                            var msg = '';
                            for (var i = 0; i < as.length; i++) {
                                msg += (msg.length > 0 ? '\n' : '') + as[i].uno + ' 此批號已存在!!\n【' + as[i].action + '】單號：' + as[i].noa;
                            }
                            alert(msg);
                            Unlock(1);
                            return;
                        } else {
                            qbtnOk();
                            parent.$.fn.colorbox.close();
                        }
                        break;
					case 'style' :
						var as = _q_appendData("style", "", true);
						StyleList = new Array();
						StyleList = as;
						break;
					case 'deleUccy':
						var as = _q_appendData("uccy", "", true);
						if (as[0] != undefined) {
							ReadOnlyUno = new Array;
							for (var i = 0; i < as.length; i++) {
								var asUno = $.trim(as[i].uno);
								if (dec(as[i].gweight) > 0) {
									ReadOnlyUno.push(asUno);
								}
							}
						}
						break;
					case q_name:
						t_uccArray = _q_appendData("ucc", "", true);
						break;
				}  /// end switch
			}

			function q_popPost(s1) {
				switch (s1) {
					case 'txtUcolor_':
						
						break;
				}
			}

			function q_funcPost(t_func, result) {
				switch(t_func) {
					
				}
			}

			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$('#btnCubt').attr('disabled', 'disabled');
				}else{
					$('#btnCubt').removeAttr('disabled');
				}
			}

			function btnMinus(id) {
				_btnMinus(id);
			}

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 90%;
			}
			.c2 {
				width: 85%;
			}
			.c3 {
				width: 71%;
			}
			.c4 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			#dbbs {
				width: 2000px;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<input id="btnCubt" type="button" value="自動匯入入庫內容">
		<div id="dbbs">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:White; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:15px;"> </td>
					<td align="center" style="width:160px;"><a id='lblUno_na'>批號</a></td>
					<td align="center" style="width:160px;"><a id='lblUcolor_na'>品號</a></td>
					<td align="center" style="width:45px;"><a id='lblStyle_na'>型</a></td>
					<td align="center" style="width:200px;"><a id='lblProduct_na'>品名/規格</a></td>
					<td align="center" style="width:125px;"><a id='lblProductno_na'>材質</a></td>
					<td align="center" style="width:85px;"><a id='lblRadius_na'>短徑</a></td>
					<td align="center" style="width:85px;"><a id='lblWidth_na'>長徑</a></td>
					<td align="center" style="width:85px;"><a id='lblDime_na'>厚度</a></td>
					<td align="center" style="width:85px;"><a id='lblLengthb_na'>長度</a></td>
					<td align="center" style="width:85px;"><a id='lblMount_na'>數量</a></td>
					<td align="center" style="width:85px;"><a id='lblWeight_na'>重量</a><br><a id='totWeight'> </a></td>
					<td align="center" style="width:100px;"><a id='lblDatea'> </a></td>
					<td align="center" style="width:120px;"><a id='lblStoreno'> </a></td>
					<td align="center" style="width:220px;"><a id='lblMemo_na'>備註</a></td>
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td style="width:1%;"><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td style="text-align:center;">
						<a id="lblNo.*"> </a>
						<input type="text" id="txtNoa.*" class="txt c1" style="display:none;"/>
						<input type="hidden" id="txtNoq.*"/>
						<input type="hidden" id="txtSource.*"/>
					</td>
					<td><input type="text" id="txtUno.*" class="txt c1"/></td>
					<td><input type="text" id="txtUcolor.*" class="txt c1"/></td>
					<td><input type="text" id="txtStyle.*" class="txt c1" style="text-align: center;"/></td>
					<td>
						<input type="text" id="txtProduct.*" class="txt c1"/>
						<input type="text" id="txtSpec.*" class="txt c1"/>
					</td>
					<td>
						<input type="text" id="txtProductno.*" class="txt c1"/>
						<input type="text" id="txtScolor.*" class="txt c1"/>
					</td>
					<td><input type="text" id="txtRadius.*" class="txt num c1"/></td>
					<td><input type="text" id="txtWidth.*" class="txt num c1"/></td>
					<td><input type="text" id="txtDime.*" class="txt num c1"/></td>
					<td><input type="text" id="txtLengthb.*" class="txt num c1"/></td>
					<td><input type="text" id="txtMount.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtWeight.*" class="txt c1 num"/></td>
					<td><input type="text" id="txtDatea.*" class="txt c1"/></td>
					<td>
						<input id="btnStoreno.*" type="button" value="." class="txt btn" style="width:1%;"/>
						<input type="text" id="txtStoreno.*" class="txt c3"/>
						<input type="text" id="txtStore.*" class="txt c1"/>
					</td>
					<td>
						<input type="text" id="txtMemo.*" class="txt c1"/>
						<input type="text" id="txtWorker.*" style="display:none;"/>
					</td>
					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>