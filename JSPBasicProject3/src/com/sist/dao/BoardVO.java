package com.sist.dao;
import java.util.*;

import lombok.Getter;
import lombok.NonNull;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {
	private int no;
	private String name;
	private String subject;
	private String content;
	private String pwd;
	private Date regdate;
	private int hit;
	private int group_id;
	private int group_step;
	private int group_tab;
	private int root;
	private int depth;
}
