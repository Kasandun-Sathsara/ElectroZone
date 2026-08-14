<%@ page import="java.io.File" %>
<%
    String realPath = application.getRealPath("/assets/img/product");
    out.println("Path: " + realPath + "\n");
    File dir = new File(realPath);
    if (dir.exists()) {
        File[] files = dir.listFiles();
        if (files != null) {
            for (File f : files) {
                out.println(f.getName() + (f.isDirectory() ? " (DIR)" : ""));
            }
        }
    } else {
        out.println("Directory does not exist!");
    }
%>
