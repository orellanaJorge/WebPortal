<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
String fecha = request.getParameter("fecha");
if( (fecha==null) || (fecha.length()==0) ){
 cl.ips.basedatos.BdConeccion rfec = new cl.ips.basedatos.BdConeccion();
 rfec.setSql("select distinct trunc(LAST_UPDATE) LAST_UPDATE ,  to_char(trunc(LAST_UPDATE), 'ddmmyyyy') from PASO_RUN_POT where excaja <> 'S.S.S' order by 1 desc");
 fecha = rfec.SQL_Dev_String_Env_Sql(2);
 rfec = null;
}

String formaP = request.getParameter("formaP");if( (formaP==null) || (formaP.length()==0) ){formaP = "";}
String sucursal = request.getParameter("sucursal");if( (sucursal==null) || (sucursal.length()==0) ){sucursal = "";}

int sumaColores[] = new int[10];
sumaColores[1] = 0;
sumaColores[2] = 1;
sumaColores[3] = 4;
sumaColores[4] = 5;
sumaColores[5] = 6;
sumaColores[6] = 7;
sumaColores[7] = 8;
int subTotal1 = 0;int subTotal2 = 0;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Empart</title>
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
        <table width="903" border="0" align="center">
          <tr>
            <td width="897">
              <form name="form1" method="post" action="">
            <table width="650" border="0" align="left" cellspacing="0">
          <tr>
            <td width="197" bgcolor="#FFFF99" id="aa" style="text-align: left">Ultima Actualización</td>
            <td width="6">:</td>
            <td width="416" style="text-align: left">
              <%
            String Matriz[][] = new String[5000][20];
            String MatrizColores[][] = new String[5000][20];

            cl.ips.funreporte.util ut = new cl.ips.funreporte.util();
            MatrizColores = ut.coloresMayo();
            ut=null;

            try{
                cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
                xp.setSql("select distinct to_char(trunc(LAST_UPDATE), 'yyyymmdd') a , to_char(trunc(LAST_UPDATE), 'ddmmyyyy') b ,to_char(trunc(LAST_UPDATE), 'dd/mm/yyyy') c from PASO_RUN_POT where excaja <> 'S.S.S'order by 1 desc");
                xp.setValorRepuestaColumnas(3);
                Matriz = xp.SQL_Dev_Matriz_Env_Sql();
                xp=null;
                }catch(Exception e){System.out.println("Error : " + e);}
            %>
              <select name="fecha" id="fecha" onChange="submit()">
                <%int a=1;while(!Matriz[a][1].trim().equals("FIN")){%>
                <%if(fecha.trim().equals(Matriz[a][2].trim())){%>
                <option value="<%=Matriz[a][2].trim()%>" selected><%=Matriz[a][3].trim()%></option>
                <%}else{%>
                <option value="<%=Matriz[a][2].trim()%>"><%=Matriz[a][3].trim()%></option>
                <%}%>
                <%a++;}%>
              </select>

            </td>
            </tr>
          <tr>
            <td bgcolor="#FFFF99" id="aa" style="text-align: left">Forma de Pago</td>
            <td>:</td>
            <td style="text-align: left">
              <%
            Matriz=null;
            try{
                cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
                xp.setSql("select distinct FORMAPAGO from   PASO_RUN_POT  where trunc(LAST_UPDATE) = to_date('" + fecha.trim()+ "','ddmmyyyy')   and FX_SOLICITUD is not null and formapago is not null");
                xp.setValorRepuestaColumnas(1);
                Matriz = xp.SQL_Dev_Matriz_Env_Sql();
                xp=null;
                }catch(Exception e){System.out.println("Error : " + e);}
             %>
              <select name="formaP" id="formaP" onChange="submit()">
                <option value="" selected> Todos --></option>
                <%a=1;while(!Matriz[a][1].trim().equals("FIN")){%>
                <%if(!formaP.trim().equals("") && formaP.trim().equals(Matriz[a][1].trim())){%>
                <option value="<%=Matriz[a][1].trim()%>" selected><%=Matriz[a][1].trim()%></option>
                <%}else{%>
                <option value="<%=Matriz[a][1].trim()%>"><%=Matriz[a][1].trim()%></option>
                <%}%>
                <%a++;}%>
              </select>

            </td>
            </tr>
          <tr>
            <td bgcolor="#FFFF99" id="aa" style="text-align: left">Sucursal IPS</td>
            <td>:</td>
            <td style="text-align: left">
              <%
            Matriz=null;
            try{
                cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
                xp.setSql("select distinct trim(SUCURSALIPS) from   PASO_RUN_POT where trunc(LAST_UPDATE) = to_date('" + fecha.trim() + "','ddmmyyyy')and FX_SOLICITUD is not null order by 1");
                xp.setValorRepuestaColumnas(1);
                Matriz = xp.SQL_Dev_Matriz_Env_Sql();
                xp=null;
                }catch(Exception e){System.out.println("Error : " + e);}
            %>
              <select name="sucursal" id="sucursal" onChange="submit()">
                <option value="" selected> Todos --></option>
                <%a=1;while(!Matriz[a][1].trim().equals("FIN")){%>
                <%if(!sucursal.trim().equals("") && sucursal.trim().equals(Matriz[a][1].trim())){%>
                <option value="<%=Matriz[a][1].trim()%>" selected><%=Matriz[a][1].trim()%></option>
                <%}else{%>
                <option value="<%=Matriz[a][1].trim()%>"><%=Matriz[a][1].trim()%></option>
                <%}%>
                <%a++;}%>
              </select>

            </td>
            </tr>
        </table>
        </form>
              <table width="150" border="0" align="right" cellspacing="0">
          <tr>
            <td><form name="form2" method="post" action="../ReportesG_XLS/EmpartXLS.jsp?fecha=<%=fecha%>&formaP=<%=formaP%>&sucursal=<%=sucursal%>">
            <input style="background-color:#FF0000;width:94px;height:47px;background:url(../images/excelFile.png);" type="submit" name="fgdfg   " value="">

            </form></td>
          </tr>
        </table></td>
          </tr>
        </table>


<br>
        <%
        if(formaP.trim().equals("")){formaP = "null";}else{formaP="'" + formaP + "'";}
        if(sucursal.trim().equals("")){sucursal = "null";}else{sucursal="'" + sucursal + "'";}

        if(formaP.trim().equals("") || sucursal.trim().equals("") ){Matriz[1][1]="FIN";}else{
        try{
            cl.ips.basedatos.BdConeccion xp = new cl.ips.basedatos.BdConeccion();
            String sql = "";
            sql= " select distinct to_char(FX_SOLICITUD, 'yyyymmdd') ff , to_char(FX_SOLICITUD, 'dd/mm/yyyy') ";
            sql+= " , ret_cant_dia( to_date('03052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"03/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('04052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"04/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('09052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"09/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('10052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"10/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('11052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"11/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('14052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"14/05/2012\" ";
            sql+= " , ret_cant_dia( to_date('15052012','ddmmyyyy') ,FX_SOLICITUD," +formaP + "," + sucursal+ ",'" + fecha.trim()+ "') as \"15/05/2012\" ";

            sql+= " from PASO_RUN_POT ";
            sql+= " where trunc(last_update) = to_date('" + fecha.trim()+ "','ddmmyyyy')";
            sql+= " and excaja <> 'S.S.S'";
            sql+= " and FX_SOLICITUD is not null";
            sql+= " order by 1";
            
            //out.println(sql);
            xp.setSql(sql);
            xp.setValorRepuestaColumnas(9);
            Matriz = xp.SQL_Dev_Matriz_Env_Sql();
            //////////////////////



            //////////////////////
            xp=null;
        }catch(Exception e){System.out.println("Error : " + e);}
        }
        %>

        <%if(!Matriz[1][1].trim().equals("FIN")){%>
    <table width="900" border="1" align="center" cellspacing="0">
  <tr bgcolor="#FFFF00">
    <td colspan="9">
     <table width="103" border="0" align="center">
        <tr>
          <td width="142"><span id="bb">Fecha de Pago</span></td>
        </tr>
    </table>
    </td>
  </tr>
  <tr>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">Cantidad de Pagos Programados</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">1</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">2</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">1.994</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">947</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">1.058</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">963</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">18</span></td>
    <td width="100"  bgcolor="#66CC66" id="al"><span id="bb">4.983</span></td>
  </tr>
  <tr>
    <td bgcolor="#FFFF99" id="al"><span id="bb">Fecha Solicitud</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">03- may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">04-may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">09-may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">10-may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">11-may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">14-may</span></td>
    <td bgcolor="#FFFF00" id="al"><span id="bb">15-may</span></td>
    <td id="al"><span id="bb">Subtotal</span></td>
  </tr>

  <%
  a = 1;
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
    <td id="al"><span id="bb">
      <%
                int h =Integer.parseInt(Matriz[a][3]) + Integer.parseInt(Matriz[a][4]);
                h+=Integer.parseInt(Matriz[a][5]) + Integer.parseInt(Matriz[a][6]);
                h+=Integer.parseInt(Matriz[a][7]) + Integer.parseInt(Matriz[a][8]);
                h+=Integer.parseInt(Matriz[a][9]);
                out.println(h);
            %>
    </span></td>
  </tr>
  <%a++;}a--;%>
</table>
<br>



<%
int res = 0;
int MatrizResultados[][] = new int[10][10];
int j=1;
int h=3;
%>
    <table width="900" border="1" align="center" cellspacing="0"  BORDERCOLOR="WHITE" >
    <tr>
    <td width="100" bgcolor="#FFFF99">
    <span class="cc" id="cc">ANTES AVISO</span>
    </td>
    <%while(j<=7){%>
    <td width="100"  bgcolor="#FFFF99" id="al">
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
       subTotal1 = res;out.println(res);%>
     </span>
    </td>
    </tr>


          <tr>
            <td width="100"  bgcolor="#FFFF99"><span class="cc" id="cc">DESPUES AVISO</span></td>
             <%
             res=0;j=1;h=3;
             while(j<=7){%>
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
               subTotal2 = res;
               out.println(res);
              %>
            </span>
            </td>
          </tr>

          <tr>
            <td width="100" bgcolor="#FFFF99"><span class="cc" id="cc">SUBTOTAL</span></td>
            <%j=1;while(j<=7){%>
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
            <td bgcolor="#0099CC" id="al">
              <span class="cc" id="cc">
              <%
                  double s = (double)(subTotal1+subTotal2) / 4983;
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