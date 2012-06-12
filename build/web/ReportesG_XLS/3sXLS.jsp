<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader("Content-Disposition", "attachment;filename=\"Empart.xls\"");

String fecha = request.getParameter("fecha");
if( (fecha==null) || (fecha.length()==0) ){
 cl.ips.basedatos.BdConeccion rfec = new cl.ips.basedatos.BdConeccion();
 rfec.setSql("select distinct trunc(LAST_UPDATE) LAST_UPDATE ,  to_char(trunc(LAST_UPDATE), 'ddmmyyyy') from PASO_RUN_POT where excaja = 'S.S.S' order by 1 desc");
 fecha = rfec.SQL_Dev_String_Env_Sql(2);
 rfec = null;
}

String formaP = request.getParameter("formaP");if( (formaP==null) || (formaP.length()==0) ){formaP = "";}
String sucursal = request.getParameter("sucursal");if( (sucursal==null) || (sucursal.length()==0) ){sucursal = "";}

int sumaColores[] = new int[50];
sumaColores[1] = 0;
sumaColores[2] = 0;
sumaColores[3] = 1;
sumaColores[4] = 2;
sumaColores[5] = 3;
sumaColores[6] = 4;
sumaColores[7] = 5;
sumaColores[8] = 6;
sumaColores[9] = 7;
sumaColores[10] = 8;
sumaColores[11] = 9;
sumaColores[12] = 10;
sumaColores[13] = 11;
sumaColores[14] = 12;
sumaColores[15] = 13;
sumaColores[16] = 14;
sumaColores[17] = 15;
sumaColores[18] = 16;
sumaColores[19] = 17;
sumaColores[20] = 18;
sumaColores[21] = 19;
int subTotal1 = 0;int subTotal2 = 0;
String Matriz[][] = new String[5000][20];
String MatrizColores[][] = new String[5000][20];

cl.ips.funreporte.util ut = new cl.ips.funreporte.util();
MatrizColores = ut.coloresJunio();
ut=null;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>3s</title>
<style type="text/css">
<!--
#aa {
	font-family: Verdana, Geneva, sans-serif;
}
#aa {
	font-size: 12px;
}
#bb {
	font-family: Verdana, Geneva, sans-serif;
}
#bb {
	font-size: 12px;
}
#cc {
	font-family: Verdana, Geneva, sans-serif;
}
.cc {
	font-size: 12px;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
#al {
	text-align: center;
}
-->
</style>
</head>
<body>












<br>
        <%
        if(formaP.trim().equals("")){formaP = "null";}else{formaP="'" + formaP + "'";}
        if(sucursal.trim().equals("")){sucursal = "null";}else{sucursal="'" + sucursal + "'";}

        if(formaP.trim().equals("") || sucursal.trim().equals("") ){Matriz[1][1]="FIN";}else{
        try{
            cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
            String sql = "";
            sql= " select distinct to_char(FX_SOLICITUD, 'yyyymmdd') ff , to_char(FX_SOLICITUD, 'dd/mm/yyyy') ";
            sql+= " , ret_cant_diasss( to_date('01062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"01/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('04062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"04/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('05062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"05/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('06062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"16/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('07062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"17/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('08062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"18/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('11062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"11/06/2012\" ";

            sql+= " , ret_cant_diasss( to_date('12062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"12/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('13062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"13/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('14062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"14/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('15062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"15/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('18062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"18/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('19062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"19/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('20062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"20/06/2012\" ";

            sql+= " , ret_cant_diasss( to_date('21062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"21/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('22062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"22/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('25062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"25/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('26062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"26/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('27062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"27/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('28062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"28/06/2012\" ";
            sql+= " , ret_cant_diasss( to_date('29062012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"29/06/2012\" ";

            //sql+= " from PASO_RUN_POT ";
            //sql+= " where FX_SOLICITUD is not null ";
            //sql+= " and excaja = 'S.S.S' ";
            //sql+= " order by 1 ";

            sql+= " from PASO_RUN_POT ";
            sql+= " where trunc(last_update) = to_date('" + fecha.trim()+ "','ddmmyyyy')";
            sql+= " and excaja = 'S.S.S'";
            sql+= " and FX_SOLICITUD is not null";
            sql+= " order by 1";


            //out.println(sql);
            xp.setSql(sql);
            xp.setValorRepuestaColumnas(23);
            Matriz = xp.SQL_Dev_Matriz_Env_Sql();
            xp=null;
        }catch(Exception e){System.out.println("Error : " + e);}
        }
        %>

        <%if(!Matriz[1][1].trim().equals("FIN")){%>
    <table width="1200" border="1" align="center" cellspacing="0">
  <tr bgcolor="#FFFF00">
    <td colspan="23">
     <table width="103" border="0" align="center">
        <tr>
          <td width="142">
              <span id="bb">Fecha de Pago</span>
          </td>
        </tr>
    </table>
    </td>
  </tr>

  <tr>
    <td width="150"  bgcolor="#66CC66" id="al"><span id="bb">Cantidad de Pagos Programados</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">983</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">948</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">1.202</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">901</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">934</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">903</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">697</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">818</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">746</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">707</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">576</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">825</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">586</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">605</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">730</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">673</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">971</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">688</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">680</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">702</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">767</span></td>
    <td width="120"  bgcolor="#66CC66" id="al"><span id="bb">16.642</span></td>
  </tr>

  <tr>
    <td bgcolor="#FFFF99" id="al"><span id="bb">Fecha Solicitud</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">01-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">04-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">05-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">06-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">07-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">08-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">11-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">12-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">13-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">14-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">15-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">18-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">19-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">20-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">21-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">22-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">25-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">26-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">27-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">28-jun</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">29-jun</span></td>
    <td id="al"><span id="bb">Subtotal</span></td>
  </tr>

  <%
  int a = 1;
  while(!Matriz[a][1].trim().equals("FIN")){
  %>
  <tr>
    <td bgcolor="<%=MatrizColores[a][2]%>" id="al"><span id="bb"><%=Matriz[a][2]%></span></td>
    <td bgcolor="<%=MatrizColores[a][3]%>" id="al"><span id="bb"><%=Matriz[a][3]%></span></td>
    <td bgcolor="<%=MatrizColores[a][4]%>" id="al"><span id="bb"><%=Matriz[a][4]%></span></td>
    <td bgcolor="<%=MatrizColores[a][5]%>" id="al"><span id="bb"><%=Matriz[a][5]%></span></td>
    <td bgcolor="<%=MatrizColores[a][6]%>" id="al"><span id="bb"><%=Matriz[a][6]%></span></td>
    <td bgcolor="<%=MatrizColores[a][7]%>" id="al"><span id="bb"><%=Matriz[a][7]%></span></td>
    <td bgcolor="<%=MatrizColores[a][8]%>" id="al"><span id="bb"><%=Matriz[a][8]%></span></td>
    <td bgcolor="<%=MatrizColores[a][9]%>" id="al"><span id="bb"><%=Matriz[a][9]%></span></td>
    <td bgcolor="<%=MatrizColores[a][10]%>" id="al"><span id="bb"><%=Matriz[a][10]%></span></td>
    <td bgcolor="<%=MatrizColores[a][11]%>" id="al"><span id="bb"><%=Matriz[a][11]%></span></td>
    <td bgcolor="<%=MatrizColores[a][12]%>" id="al"><span id="bb"><%=Matriz[a][12]%></span></td>
    <td bgcolor="<%=MatrizColores[a][13]%>" id="al"><span id="bb"><%=Matriz[a][13]%></span></td>
    <td bgcolor="<%=MatrizColores[a][14]%>" id="al"><span id="bb"><%=Matriz[a][14]%></span></td>
    <td bgcolor="<%=MatrizColores[a][15]%>" id="al"><span id="bb"><%=Matriz[a][15]%></span></td>
    <td bgcolor="<%=MatrizColores[a][16]%>" id="al"><span id="bb"><%=Matriz[a][16]%></span></td>
    <td bgcolor="<%=MatrizColores[a][17]%>" id="al"><span id="bb"><%=Matriz[a][17]%></span></td>
    <td bgcolor="<%=MatrizColores[a][18]%>" id="al"><span id="bb"><%=Matriz[a][18]%></span></td>
    <td bgcolor="<%=MatrizColores[a][19]%>" id="al"><span id="bb"><%=Matriz[a][19]%></span></td>
    <td bgcolor="<%=MatrizColores[a][20]%>" id="al"><span id="bb"><%=Matriz[a][20]%></span></td>
    <td bgcolor="<%=MatrizColores[a][21]%>" id="al"><span id="bb"><%=Matriz[a][21]%></span></td>
    <td bgcolor="<%=MatrizColores[a][22]%>" id="al"><span id="bb"><%=Matriz[a][22]%></span></td>
    <td bgcolor="<%=MatrizColores[a][23]%>" id="al"><span id="bb"><%=Matriz[a][23]%></span></td>
    <td id="al"><span id="bb">
      <%
      try{
                int h =Integer.parseInt(Matriz[a][3]) + Integer.parseInt(Matriz[a][4]);
                h+=Integer.parseInt(Matriz[a][5]) + Integer.parseInt(Matriz[a][6]);
                h+=Integer.parseInt(Matriz[a][7]) + Integer.parseInt(Matriz[a][8]);
                h+=Integer.parseInt(Matriz[a][9]) +  Integer.parseInt(Matriz[a][10]);
                h+=Integer.parseInt(Matriz[a][11]) +  Integer.parseInt(Matriz[a][12]);
                h+=Integer.parseInt(Matriz[a][13]) +  Integer.parseInt(Matriz[a][14]);
                h+=Integer.parseInt(Matriz[a][15]) +  Integer.parseInt(Matriz[a][16]);
                h+=Integer.parseInt(Matriz[a][17]) +  Integer.parseInt(Matriz[a][18]);
                h+=Integer.parseInt(Matriz[a][19]) +  Integer.parseInt(Matriz[a][20]);
                h+=Integer.parseInt(Matriz[a][21]) +  Integer.parseInt(Matriz[a][22]);
                h+=Integer.parseInt(Matriz[a][23]) ;
                out.println(h);
                }catch(Exception e){}

            %>
    </span></td>
  </tr>
  <%a++;}a--;%>
</table>
<br>



<%
int res = 0;
int MatrizResultados[][] = new int[100][100];
int j=1;
int h=3;
%>
    <table width="1200" border="1" align="center" cellspacing="0"  BORDERCOLOR="WHITE" >
    <tr>
    <td width="150" bgcolor="#FFFF99">
    <span class="cc" id="cc">ANTES   AVISO&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
    </td>
    <%
    // suma antes
    while(j<=21){%>
    <td width="150"  bgcolor="#FFFF99" id="al">
        <span class="cc" id="cc">
         <%
          try{
              for(int i=1;i<=sumaColores[j];i++){
                  res+=Integer.parseInt(Matriz[i][h]);
              }
              MatrizResultados[1][j+1] = res;
              out.println(res);
          }catch(Exception e){out.println(res);MatrizResultados[1][j+1] = res;}
         %>
        </span>
    </td>
    <%j++;h++;res=0;}res=0;%>

    <td width="100" bgcolor="#FFFF99" id="al">
      <span class="cc" id="cc">
      <%
       res =  MatrizResultados[1][2] +  MatrizResultados[1][3] +  MatrizResultados[1][4] +  MatrizResultados[1][5];
       res+=  MatrizResultados[1][6] +  MatrizResultados[1][7] +  MatrizResultados[1][8];
       res+=  MatrizResultados[1][9] +  MatrizResultados[1][10] +  MatrizResultados[1][11];
       res+=  MatrizResultados[1][12] +  MatrizResultados[1][13] +  MatrizResultados[1][14];
       res+=  MatrizResultados[1][15] +  MatrizResultados[1][16] +  MatrizResultados[1][17];
       res+=  MatrizResultados[1][18] +  MatrizResultados[1][19] +  MatrizResultados[1][20];
       res+=  MatrizResultados[1][21] +  MatrizResultados[1][22];
       subTotal1 = res;out.println(res);%>
     </span>
    </td>
    </tr>


          <tr>
            <td width="120"  bgcolor="#FFFF99"><span class="cc" id="cc">DESPUES   AVISO</span></td>
             <%
             res=0;j=1;h=3;
             while(j<=21){%>
             <td width="100"  bgcolor="#FFFF99" id="al">
                 <span class="cc" id="cc">
                  <%
                     for(int i=sumaColores[j]+1;i<=a;i++){
                       res+=Integer.parseInt(Matriz[i][h]);
                   }
                   MatrizResultados[2][j+1] = res;
                   out.println(res);
                  %>
                 </span>
             </td>
             <%j++;h++;res=0;}res=0;%>

            <td bgcolor="#FFFF99" id="al">
              <span class="cc" id="cc">
              <%
               res =  MatrizResultados[2][2] +  MatrizResultados[2][3] +  MatrizResultados[2][4] +  MatrizResultados[2][5];
               res+=  MatrizResultados[2][6] +  MatrizResultados[2][7] +  MatrizResultados[2][8];
               res+=  MatrizResultados[2][9] +  MatrizResultados[2][10] +  MatrizResultados[2][11];
               res+=  MatrizResultados[2][12] +  MatrizResultados[2][13] +  MatrizResultados[2][14];
               res+=  MatrizResultados[2][15] +  MatrizResultados[2][16] +  MatrizResultados[2][17];
               res+=  MatrizResultados[2][18] +  MatrizResultados[2][19] +  MatrizResultados[2][20];
               res+=  MatrizResultados[2][21] +  MatrizResultados[2][22];
               subTotal2 = res;
               out.println(res);
              %>
            </span>
            </td>
          </tr>

          <tr>
            <td width="100" bgcolor="#FFFF99"><span class="cc" id="cc">SUBTOTAL</span></td>
            <%j=1;while(j<=21){%>
            <td bgcolor="#FFFF99" id="al">
              <span class="cc" id="cc">
              <%
               out.println(MatrizResultados[1][j+1] +  MatrizResultados[2][j+1]);
              %>
            </span>
            </td>
            <%j++;}%>


          <td bgcolor="#FFFF99" id="al">
          <span class="cc" id="cc">
          <%out.println(subTotal1+subTotal2);%>
          </span>
          </td>

          </tr>

          <tr>
            <td>&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td id="al">&nbsp;</td>
            <td bgcolor="#0099CC" id="al">
              <span class="cc" id="cc">
              <%
                  double s = (double)(subTotal1+subTotal2) / 16642;
                  s = s * 100;
                  DecimalFormat df = new DecimalFormat("#.##");
                  out.print(df.format(s) + "%");
              %>
            </span></td>
          </tr>
        </table>
    <%}%>
<br>
    <br>
    <h1>&nbsp;</h1>
</body>
</html>