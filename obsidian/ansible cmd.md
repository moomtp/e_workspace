deploy include inventory
```bash
# 運行target yml檔 並套用設定檔inventory.yml
ansible-playbook -i inventory.yml {target yml}  

# 在遇到輸入密碼時使用互動式輸入
ansible-playbook playbook.yml --ask-become-pass
```


# playbook structure
```
- name: 

- debug: ＃ 會把任務中的var print出來
	var: 
- k8s:
	state: present  # 使用dploy的方式套用下面的設定
	definition: # 照k8s中的設定檔寫就好了
	
```