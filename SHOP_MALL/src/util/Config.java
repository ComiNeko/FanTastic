package util;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class Config {
    private static Properties properties = new Properties();

    static {
        try {
            // config.properties 파일을 로드
            properties.load(new FileInputStream("config.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getApiUrl() {
        return properties.getProperty("portone.api.url");
    }

    public static String getAuthKey() {
        return properties.getProperty("portone.auth.key");
    }
}
