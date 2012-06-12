package cl.ips.basedatos;

import java.sql.*;

public class BdConeccion {
    
    private int valorRepuestaColumnas;
    private String sql;
    private String storeProceduar;
    private Connection con;
    private ResultSet rset;    
    private String[][] Matriz = new String[5000][20];

    public void setSql(String sql) {
        this.sql = sql;
    }

    public void setStoreProceduar(String storeProceduar) {
        this.storeProceduar = storeProceduar;
    }

    public void setValorRepuestaColumnas(int valorRepuestaColumnas) {
        this.valorRepuestaColumnas = valorRepuestaColumnas;
    }
  
    public String SQL_Dev_String_Env_Sql(int valor) {
        String dato = "";
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            con = this.conecta();
            rset = con.createStatement().executeQuery(sql);
            if (rset.next()) {dato = rset.getString(valor);}
            con.close();
            con = null;
            rset.close();
            rset = null;
            return dato;
        } catch (Exception e) {return "";}
    }

    public String[][] SQL_Dev_Matriz_Env_Sql() {
        String matrizGastos[][] = new String[1000][40];
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            con = this.conecta();
            rset = con.createStatement().executeQuery(sql);
            int j = 1;
            while (rset.next()) {
                for (int g = 1; g <= valorRepuestaColumnas; g++) {
                    matrizGastos[j][g] = rset.getString(g);
                }
                j++;
            }
            matrizGastos[j][1] = "FIN";
            con.close();
            con = null;
            rset.close();
            rset = null;
            return matrizGastos;
        } catch (Exception e) {
            return null;
        }
    }

    public int[][] SQL_Dev_MatrizI_Env_Sql() {
        int matrizGastos[][] = new int[1000][40];
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
            con = this.conecta();
            rset = con.createStatement().executeQuery(sql);
            int j = 1;
            while (rset.next()) {
                for (int g = 1; g <= valorRepuestaColumnas; g++) {
                    matrizGastos[j][g] = rset.getInt(g);
                }
                j++;
            }
            matrizGastos[j][1] = 999999;
            con.close();
            con = null;
            rset.close();
            rset = null;
            return matrizGastos;
        } catch (Exception e) {
            return null;
        }
    }

    public void SQL_Ejecuta_Accion_Update_Insert_Delete() {
        try {
            con = this.conecta();
            rset = con.createStatement().executeQuery(sql);
            con.close();
            con = null;
            rset = null;
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
    }

    private Connection conecta() {
        try {
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());            
            con = DriverManager.getConnection("jdbc:oracle:thin:@10.150.167.24:1521:xe", "DM_REPORT", "d123456");
            return con;
        } catch (Exception e) {
            return null;
        }
    }

    /*
    public String[][] SQL_Dev_RST_StoreProceduare(String storeProceduar, int dev, int conecc) {
    String[][] Matriz = new String[1500][50];
    int x = 1;
    try {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection con = this.conecta(conecc);
    CallableStatement cs;
    ResultSet rs = null;
    cs = con.prepareCall(storeProceduar);
    cs.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
    cs.execute();
    rs = (ResultSet) cs.getObject(1);
    cs.close();

    while (rs.next()) {
    for (int i = 1; i <= dev; i++) {
    if ((rs.getString(i) == null)) {
    Matriz[x][i] = "-";
    } else {
    Matriz[x][i] = rs.getString(i);
    }
    }

    x++;
    }

    Matriz[x][1] = "FIN";
    con.close();
    } catch (Exception e) {
    Matriz[x][1] = String.valueOf("Err: " + e);
    Matriz[x + 1][1] = "FIN";
    }
    return Matriz;
    }

    public String SQL_StoreProcedure_3Val(String proceduar, int conecc, String uno, String dos, String tres) {
    try {
    Connection con = this.conecta(conecc);
    CallableStatement cs;
    cs = con.prepareCall(proceduar);
    cs.registerOutParameter(1, Types.CHAR);
    cs.setString(1, uno.trim());

    cs.registerOutParameter(2, Types.CHAR);
    cs.setString(2, dos.trim());

    cs.registerOutParameter(3, Types.CHAR);
    cs.setString(3, tres);

    cs.execute();
    cs.close();
    } catch (Exception e) {
    System.out.println("!!!!!!Error 3 Val: " + e + "Parametro:1 " + uno + " - " + "Parametro 3:" + tres + " - " + "Parametro 2:" + dos);
    }
    return "";
    }

    public String SQL_StoreProcedure_Trigger(String proceduar, int conecc, String info) {
    try {
    Connection con = this.conecta(conecc);
    CallableStatement cs;
    cs = con.prepareCall(proceduar);
    cs.execute();
    cs.close();
    return "Ok";
    } catch (Exception e) {
    System.out.println("!!!!!!Error TRIGGER : " + info + " - " + e);
    return "!!!!!!Error TRIGGER : " + info + " - " + e;
    }

    }

    public String[][] StoreProceduare(String storeProceduar, int dev) {
    String[][] Matriz = new String[500][10];
    int x = 1;
    try {
    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@201.238.227.115:1521:XE", "bcoestado ", "cbE27419");
    CallableStatement cs;
    ResultSet rs = null;
    cs = con.prepareCall(storeProceduar);
    cs.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
    cs.execute();
    rs = (ResultSet) cs.getObject(1);
    cs.close();

    while (rs.next()) {
    if (dev == 1) {
    Matriz[x][1] = rs.getString(1);
    }

    if (dev == 2) {
    Matriz[x][1] = rs.getString(1);
    Matriz[x][2] = rs.getString(2);
    }

    if (dev == 3) {
    Matriz[x][1] = rs.getString(1);
    Matriz[x][2] = rs.getString(2);
    Matriz[x][3] = rs.getString(3);
    }

    if (dev == 4) {
    Matriz[x][1] = rs.getString(1);
    Matriz[x][2] = rs.getString(2);
    Matriz[x][3] = rs.getString(3);
    Matriz[x][4] = rs.getString(4);
    }

    x++;
    }
    Matriz[x][1] = "FIN";
    con.close();
    } catch (Exception e) {
    System.out.println("Error Call Store : " + e);
    }
    return Matriz;
    }
     */
}
