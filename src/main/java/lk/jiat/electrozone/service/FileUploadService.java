package lk.jiat.ElectroZone.service;

import jakarta.servlet.ServletContext;
import jakarta.ws.rs.WebApplicationException;
import lk.jiat.ElectroZone.util.Env;
import org.apache.commons.io.FilenameUtils;
import org.glassfish.jersey.media.multipart.ContentDisposition;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class FileUploadService {
    private static final String UPLOAD_DIRECTORY_NAME = "/assets/img";
    private final ServletContext context;

    public FileUploadService(ServletContext context) {
        this.context = context;
    }

    public FileItem uploadFile(String directoryName, InputStream inputStream, ContentDisposition fileMetaData) {
        return writeFile(UPLOAD_DIRECTORY_NAME + "/" + directoryName, inputStream, fileMetaData);
    }

    private FileItem writeFile(String pathName, InputStream inputStream, ContentDisposition contentDisposition) {
        Path deployPath = Paths.get(context.getRealPath(pathName));
        Path sourcePath = Paths.get("e:/Github/ElectroZone/src/main/webapp" + pathName);
        
        String extension = FilenameUtils.getExtension(contentDisposition.getFileName());
        String fileName = java.util.UUID.randomUUID().toString() + "." + extension;

        try {
            if (!Files.exists(deployPath)) Files.createDirectories(deployPath);
            if (!Files.exists(sourcePath)) Files.createDirectories(sourcePath);
            
            byte[] bytes = inputStream.readAllBytes();
            
            // Write to deployment folder (for instant viewing)
            try (OutputStream os1 = new FileOutputStream(deployPath + "/" + fileName)) {
                os1.write(bytes);
                os1.flush();
            }
            
            // Write to source folder (for persistence across restarts)
            try (OutputStream os2 = new FileOutputStream(sourcePath + "/" + fileName)) {
                os2.write(bytes);
                os2.flush();
            }
        } catch (IOException e) {
            e.printStackTrace();
            throw new WebApplicationException("Error while file uploading! Try Again...");
        }

        String appUrl = Env.get("app.url");
        String relativePath = pathName + "/" + fileName;
        String url = context.getContextPath() + "/" + relativePath;
        // We will just store the path relative to the app root, e.g. uploads/...
        String path = relativePath; 
        
        String fullUrl = appUrl + url;

        return new FileItem(fileName, contentDisposition.getFileName(), path, url, fullUrl);
    }

    public static class FileItem {
        private String fileName;
        private String originalFileName;
        private String filePath;
        private String url;
        private String fullUrl;

        public FileItem(String fileName, String originalFileName, String filePath, String url, String fullUrl) {
            this.fileName = fileName;
            this.originalFileName = originalFileName;
            this.filePath = filePath;
            this.url = url;
            this.fullUrl = fullUrl;
        }

        public void setFileName(String fileName) {
            this.fileName = fileName;
        }

        public void setOriginalFileName(String originalFileName) {
            this.originalFileName = originalFileName;
        }

        public void setFilePath(String filePath) {
            this.filePath = filePath;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public void setFullUrl(String fullUrl) {
            this.fullUrl = fullUrl;
        }

        public String getFileName() {
            return fileName;
        }

        public String getOriginalFileName() {
            return originalFileName;
        }

        public String getFilePath() {
            return filePath;
        }

        public String getUrl() {
            return url;
        }

        public String getFullUrl() {
            return fullUrl;
        }
    }
}
