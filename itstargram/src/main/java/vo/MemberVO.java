package vo;

import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

public class MemberVO {
	private int num;
	private String id, pwd;
	private String name, email, tel;
	private String profile;
	private String follow_json, saved_list, tagged_list;
	
	private List<Integer[]> list = new ArrayList<Integer[]>();
	private Integer[] followers = new Integer[0], followings = new Integer[0];

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		if(name == null) name = "";
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		if(tel == null) tel = "";
		this.tel = tel;
	}

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

	public String getFollow_json() {
		return follow_json;
	}

	public void setFollow_json(String follow_json) {
		this.follow_json = follow_json;
		
		List<Integer[]> list = new Gson().fromJson(getFollow_json(), new TypeToken<ArrayList<Integer[]>>() {}.getType());
		if(list != null) this.list = list;
		
		followers = (this.list.get(0) != null) ? this.list.get(0) : new Integer[]{};
		followings = (this.list.get(1) != null) ? this.list.get(1) : new Integer[]{};
	}

	public String getSaved_list() {
		return saved_list;
	}

	public void setSaved_list(String saved_list) {
		this.saved_list = saved_list;
	}

	public String getTagged_list() {
		return tagged_list;
	}

	public void setTagged_list(String tagged_list) {
		this.tagged_list = tagged_list;
	}
	
// ==================================================
	
	{
		list.add(0, null);
		list.add(1, null);
	}
	
	public Integer[] getFollowers() {
		return followers;
	}
	
	public void setFollowers(Integer[] followers) {
		this.followers = followers;
		
		list.set(0, followers);
		follow_json = new Gson().toJson(list);
	}
	
	public Integer[] getFollowings() {
		return followings;
	}
	
	public void setFollowings(Integer[] followings) {
		this.followings = followings;
		
		list.set(1, followings);
		follow_json = new Gson().toJson(list);
	}
}
