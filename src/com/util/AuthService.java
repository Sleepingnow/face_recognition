package com.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sql.AddAttend;




/**
 * 获取token类
 */
public class AuthService {

    /**
     * 获取权限token
     * @return 返回示例：
     * {
     * "access_token": "24.460da4889caad24cccdb1fea17221975.2592000.1491995545.282335-1234567",
     * "expires_in": 2592000
     * }
     */    
	public static String getAuth() {
		// 官网获取的 API Key 更新为你注册的
		String clientId = "kcfpz7kTN3vYv13YMyq5TmFF";
		// 官网获取的 Secret Key 更新为你注册的
		String clientSecret = "9KHD1TAOG7MZYkMZATAxqYTEKihuUaHd";
		return getAuth(clientId, clientSecret);
	}

    /**
     * 获取API访问token
     * 该token有一定的有效期，需要自行管理，当失效时需重新获取.
     * @param ak - 百度云官网获取的 API Key
     * @param sk - 百度云官网获取的 Secret Key
     * @return assess_token 示例：
     * "24.460da4889caad24cccdb1fea17221975.2592000.1491995545.282335-1234567"
     */
	public static String getAuth(String ak, String sk) {

		String authHost = "https://aip.baidubce.com/oauth/2.0/token?";
		String getAccessTokenUrl = authHost
				// 1. grant_type为固定参数
				+ "grant_type=client_credentials"
				// 2. 官网获取的 API Key
				+ "&client_id=" + ak
				// 3. 官网获取的 Secret Key
				+ "&client_secret=" + sk;
		try {
			URL realUrl = new URL(getAccessTokenUrl);
			// 打开和URL之间的连接
			HttpURLConnection connection = (HttpURLConnection) realUrl
					.openConnection();
			connection.setRequestMethod("GET");
			connection.connect();
			// 获取所有响应头字段
			Map<String, List<String>> map = connection.getHeaderFields();
			// 遍历所有的响应头字段
			for (String key : map.keySet()) {
				System.err.println(key + "--->" + map.get(key));
			}
			// 定义 BufferedReader输入流来读取URL的响应
			BufferedReader in = new BufferedReader(new InputStreamReader(
					connection.getInputStream()));
			String result = "";
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			/**
             * 返回结果示例
             */
			System.out.println("result:" + result);
			JSONObject jsonObject = new JSONObject(result);
			String access_token = jsonObject.getString("access_token");
			return access_token;
		} catch (Exception e) {
			System.err.printf("获取token失败！");
			e.printStackTrace(System.err);
		}
		return null;
	}

	public static String faceAdd(String img_base64,String user) {
		// 请求url
		String url = "https://aip.baidubce.com/rest/2.0/face/v3/faceset/user/add";
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("image", img_base64);
			map.put("group_id", "001");
			map.put("user_id", user);
			map.put("user_info", user);
			map.put("liveness_control", "NORMAL");
			map.put("image_type", "BASE64");
			map.put("quality_control", "NONE");

			String param = GsonUtils.toJson(map);
			String accessToken = getAuth();
			String result = HttpUtil.post(url, accessToken, "application/json",
					param);
			System.out.println("----------------faceAdd():" + result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static String faceGetList(String user_id) {

        String url = "https://aip.baidubce.com/rest/2.0/face/v3/faceset/face/getlist";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("user_id", user_id);
            map.put("group_id", "001");

            String param = GsonUtils.toJson(map);

            
            String accessToken = getAuth();

            String result = HttpUtil.post(url, accessToken, "application/json", param);
            System.out.println("------------faceGetList()::"+result);
            return result;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

	public static String faceMatch(String base64,String user_id) {

		String url = "https://aip.baidubce.com/rest/2.0/face/v3/match";
		try {
			String image1 = base64;
			
			String res = faceGetList(user_id);
			JsonObject jObject = new JsonParser().parse(res).getAsJsonObject();
			JsonObject asJsonObject = jObject.get("result").getAsJsonObject();
			JsonArray asJsonArray = asJsonObject.get("face_list").getAsJsonArray();

			String image2 = asJsonArray.get(0).getAsJsonObject().get("face_token").getAsString();
			List<Map<String, Object>> images = new ArrayList<Map<String, Object>>();

			Map<String, Object> map1 = new HashMap<String, Object>();
			map1.put("image", image1);
			map1.put("image_type", "BASE64");
			map1.put("face_type", "LIVE");
			map1.put("quality_control", "NONE");
			map1.put("liveness_control", "NORMAL");

			Map<String, Object> map2 = new HashMap<String, Object>();
			map2.put("image", image2);
			map2.put("image_type", "FACE_TOKEN");
			map2.put("face_type", "LIVE");
			map2.put("quality_control", "NONE");
			map2.put("liveness_control", "NORMAL");

			images.add(map1);
			images.add(map2);

			String param = GsonUtils.toJson(images);

			String accessToken = getAuth();

			String result = HttpUtil.post(url, accessToken, "application/json",
					param);
			System.err.println("-------------faceMatch():"+result);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean isSame(String base64, int i){
		boolean flag = false;

		List users = getUsers();
		for(Object user : users){
			String res = faceMatch(base64,user.toString());
			JsonObject jObject = new JsonParser().parse(res).getAsJsonObject();
			JsonElement jsonElement = jObject.get("result");
			float score = 0;
			if(!jsonElement.isJsonNull()){
				score = jsonElement.getAsJsonObject().get("score").getAsFloat();
			}
			if(score>90){
				flag = true;
				if(i==1) {
					AddAttend.add(user.toString());
				}
				break;
			}
		}
		return flag;
	}

	public static List getUsers() {
        String url = "https://aip.baidubce.com/rest/2.0/face/v3/faceset/group/getusers";
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("group_id", "001");

            String param = GsonUtils.toJson(map);

            
            String accessToken = getAuth();

            String result = HttpUtil.post(url, accessToken, "application/json", param);
            JSONObject jsonObject = new JSONObject(result);
            JSONObject jsonObject2 = jsonObject.getJSONObject("result");
            JSONArray jsonArray = jsonObject2.getJSONArray("user_id_list");
            List<Object> list = jsonObject2.getJSONArray("user_id_list").toList();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	public static void main(String[] args) {
		getUsers();
	}
}
