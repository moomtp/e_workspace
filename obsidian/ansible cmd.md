deploy include inventory
```
ansible-playbook -i inventory.yml {target yml}
```


# playbook structure
```
- name: 

- debug: ＃ 會把任務中的var print出來
	var: 
- k8s:
	state: present  # 使用dploy的方式套用下面的設定
	definition: # k8s中的設定檔
	
```