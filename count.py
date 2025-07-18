import os

def categorize_submissions(folder_path):
    # 初始化赛道列表
    mini_category = []
    short_category = []
    unrestricted_category = []
    innovation_category = []

    # 遍历文件夹中的文件
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        
        # 确保只处理文件，不处理子文件夹
        if os.path.isfile(file_path):
            # 根据文件名中的关键字进行分类
            if "微型" in filename:
                mini_category.append(filename)
            elif "短篇" in filename:
                short_category.append(filename)
            elif "无限制" in filename:
                unrestricted_category.append(filename)
            elif "创新" in filename:
                innovation_category.append(filename)

    # 打印每个赛道的投稿数量和文件名
    print("微型赛道投稿数量:", len(mini_category))
    print("文件名:", ",".join(mini_category) if mini_category else "无")
    
    print("\n短篇赛道投稿数量:", len(short_category))
    print("文件名:", ",".join(short_category) if short_category else "无")
    
    print("\n无限制赛道投稿数量:", len(unrestricted_category))
    print("文件名:", ",".join(unrestricted_category) if unrestricted_category else "无")
    
    print("\n创新赛道投稿数量:", len(innovation_category))
    print("文件名:", ",".join(innovation_category) if innovation_category else "无")

# 使用示例
folder_path = "文件"  # 确保文件夹路径正确
categorize_submissions(folder_path)
