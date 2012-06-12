<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=utf-8" language="java"%>
<%
int[][] subt1 = new int[100][100];
int[][] subt2 = new int[100][100];
%>
<%
   response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
   response.setHeader("Content-Disposition", "attachment;filename=\"Sdm.xls\"");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Centrar Horizontalmente</title>
	<link href="../Css/styleDivs.css" rel="stylesheet" type="text/css" media="screen" />
	<style type="text/css">
	<!--
	@import url("../Css/styleTablas.css");
	-->
	</style>
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<div id="contenido">
  <div id="izquierda">
	<table id="newspaper-b" summary="2007 Major IT Companies' Profit">
    <thead>
     <tr>
        	<th colspan="6" scope="col">RESUMEN</th>
     </tr>
    	<tr>
        	<th scope="col">Mes/a&ntilde;o</th>
            <th scope="col">Subtotal</th>
            <th scope="col">Fallecidos</th>
            <th scope="col">Total</th>
            <th scope="col">Solicidtud</th>
            <th scope="col">Inicio Solicitud</th>
        </tr>
<%
 String sql = " select fin_beneficio ";
 sql += " , cantidad   sub_total ";
 sql += " , fallecidos ";
 sql += " , (cantidad - fallecidos)  total ";
 sql += " , inicio ";
 sql += " , decode(inicio,0,null,round(((inicio/(cantidad - fallecidos))*100),2)||'%') porcentaje ";
 sql += " from (     ";
 sql += " select to_char(FX_FIN_BENEFICIO,'yyyy')    fin_beneficio ";
 sql += " , to_char(FX_FIN_BENEFICIO,'yyyy')  ord ";
 sql += " , count(*)    cantidad ";
 sql += " , sum(decode(nvl(FX_DEFUNCION,to_date('01011900','ddmmyyyy')),to_date('01011900','ddmmyyyy'),0,1)) fallecidos ";
 sql += " , sum(decode(nvl(ESTADO_SOLICITUD,'0'),'0',0,1)) inicio ";
 sql += " from  PASO_RUN_SDM ";
 sql += " group by  to_char(FX_FIN_BENEFICIO,'yyyy') ";
 sql += " , to_char(FX_FIN_BENEFICIO,'yyyy') ";
 sql += " order by   to_char(FX_FIN_BENEFICIO,'yyyy') desc  ";
 sql += " )  ";
 sql += " order by   ord    ";

 String Matriz[][] = new String[1000][500];
 try {
  cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
  xp.setSql(sql);
  xp.setValorRepuestaColumnas(6);
  Matriz = xp.SQL_Dev_Matriz_Env_Sql();
  xp = null;
 } catch (Exception e) {
  System.out.println("Error : " + e);
 }

int a = 1;
while (!Matriz[a][1].trim().equals("FIN")) {
 if (Matriz[a][1].trim().equals("9999")) {Matriz[a][1] = "";}
 if (Matriz[a][2].trim().equals("9999")) {Matriz[a][2] = "";}
 if (Matriz[a][3].trim().equals("9999")) {Matriz[a][3] = "";}
 if (Matriz[a][4].trim().equals("9999")) {Matriz[a][4] = "";}
 if (Matriz[a][5].trim().equals("9999")) {Matriz[a][5] = "";}
 if (Matriz[a][6].trim().equals("9999")) {Matriz[a][6] = "";}
%>
    </thead>
    <tbody>
 <tr>
  <td><%=Matriz[a][1].trim()%></td>
  <td><%=Matriz[a][2].trim()%></td>
  <td><%=Matriz[a][3].trim()%></td>
  <td><%=Matriz[a][4].trim()%></td>
  <td><%=Matriz[a][5].trim()%></td>
  <td><%=Matriz[a][6].trim()%></td>
 </tr>
<%
 try {subt1[1][2] += Integer.parseInt(Matriz[a][2].trim());} catch (Exception e) {}
 try {subt1[1][3] += Integer.parseInt(Matriz[a][3].trim());} catch (Exception e) {}
 try {subt1[1][4] += Integer.parseInt(Matriz[a][4].trim());} catch (Exception e) {}
 try {subt1[1][5] += Integer.parseInt(Matriz[a][5].trim());} catch (Exception e) {}
a++;
}
%>
<tr bgcolor="white" >
<td></td>
<td><b><%=subt1[1][2]%></b></td>
<td><b><%=subt1[1][3]%></b></td>
<td><b><%=subt1[1][4]%></b></td>
<td><b><%=subt1[1][5]%></b></td>
<td><b>
<%
double s = (double) subt1[1][5] / (double) subt1[1][4];
s = s * 100;
DecimalFormat df = new DecimalFormat("#.##");
out.print(df.format(s) + "%");
%>
</b>
</td>
</tr>
    </tbody>
</table>
</div>



		<div id="derecha">
		<table id="newspaper-b" summary="2007 Major IT Companies' Profit">
    <thead>
      <tr>
        	<th colspan="6" scope="col">DETALLE</th>
      </tr>
    	<tr>
        	 <th scope="col">Mes/a&ntilde;o</th>
            <th scope="col">Subtotal</th>
            <th scope="col">Fallecidos</th>
            <th scope="col">Total</th>
            <th scope="col">Solicidtud</th>
            <th scope="col">Inicio Solicitud</th>
        </tr>
    </thead>
    <tbody>
<%
Matriz = null;
 sql = "select nvl(fin_beneficio,9999) ";
sql += " , nvl(cantidad,9999)   sub_total";
sql += " , nvl(fallecidos,9999) ";
sql += " , nvl((cantidad - fallecidos),9999)  total ";
sql += " , nvl(inicio,9999) ";
sql += " , nvl(decode(inicio,0,null,round(((inicio/(cantidad - fallecidos))*100),2)||'%'),9999) porcentaje ";
sql += " from (     ";
sql += " select to_char(FX_FIN_BENEFICIO,'mm/yyyy')    fin_beneficio ";
sql += " , to_char(FX_FIN_BENEFICIO,'yyyymm')  ord ";
sql += " , count(*)    cantidad ";
sql += " , sum(decode(nvl(FX_DEFUNCION,to_date('01011900','ddmmyyyy')),to_date('01011900','ddmmyyyy'),0,1)) fallecidos ";
sql += " , sum(decode(nvl(ESTADO_SOLICITUD,'0'),'0',0,1)) inicio ";
sql += " from  PASO_RUN_SDM ";
sql += " group by  to_char(FX_FIN_BENEFICIO,'mm/yyyy') ";
sql += " , to_char(FX_FIN_BENEFICIO,'yyyymm') ";
sql += " order by   to_char(FX_FIN_BENEFICIO,'yyyymm') desc  ";
sql += " )  ";
sql += " order by   ord ";


try {
  cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
  xp.setSql(sql);
  xp.setValorRepuestaColumnas(6);
  Matriz = xp.SQL_Dev_Matriz_Env_Sql();
  xp = null;
} catch (Exception e) {System.out.println("Error : " + e);}

a = 1;
while (!Matriz[a][1].trim().equals("FIN")) {
 if (Matriz[a][1].trim().equals("9999")) {Matriz[a][1] = "";}
 if (Matriz[a][2].trim().equals("9999")) {Matriz[a][2] = "";}
 if (Matriz[a][3].trim().equals("9999")) {Matriz[a][3] = "";}
 if (Matriz[a][4].trim().equals("9999")) {Matriz[a][4] = "";}
 if (Matriz[a][5].trim().equals("9999")) {Matriz[a][5] = "";}
 if (Matriz[a][6].trim().equals("9999")) {Matriz[a][6] = "";}
%>
<tr>
<td><%=Matriz[a][1].trim()%></td>
<td><%=Matriz[a][2].trim()%></td>
<td><%=Matriz[a][3].trim()%></td>
<td><%=Matriz[a][4].trim()%></td>
<td><%=Matriz[a][5].trim()%></td>
<td><%=Matriz[a][6].trim()%></td>
</tr>
<%
 try {subt2[1][2] += Integer.parseInt(Matriz[a][2].trim());} catch (Exception e) {}
 try {subt2[1][3] += Integer.parseInt(Matriz[a][3].trim());} catch (Exception e) {}
 try {subt2[1][4] += Integer.parseInt(Matriz[a][4].trim());} catch (Exception e) {}
 try {subt2[1][5] += Integer.parseInt(Matriz[a][5].trim());} catch (Exception e) {}
a++;
}
%>
       <tr  bgcolor="white">
                            <td></td>
                            <td><b><%=subt2[1][2]%></b></td>
                            <td><b><%=subt2[1][3]%></b></td>
                            <td><b><%=subt2[1][4]%></b></td>
                            <td><b><%=subt2[1][5]%></b></td>
                            <td><b>
                                <%
                                            s = (double) subt2[1][5] / (double) subt2[1][4];
                                            s = s * 100;
                                            out.print(df.format(s) + "%");
                                %>
                            </b>
                            </td>
                        </tr>
    </tbody>
</table>
		</div>
</div>
</body>
</html>
