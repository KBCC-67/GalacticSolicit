from wordcloud import WordCloud
import matplotlib.pyplot as plt
import jieba

# 定义停用词列表
stopwords = set(['的', '了', '我', '你', '是', '很', '也', '在', '和', '就', '不', '人', '都', '一个', '有', '这个', '要','什么','没有','感觉','作者','但是','比较','可以','不过','有点','一篇','dv','https'])

# 读取文件内容
with open('ref.txt', 'r', encoding='utf-8') as file:
    text = file.read()

# 使用 jieba 分词
words = jieba.cut(text)

# 过滤停用词
filtered_words = [word for word in words if word not in stopwords and len(word) > 1]

# 将过滤后的词语连接成一个字符串
text_cut = ' '.join(filtered_words)

# 生成词云
wordcloud = WordCloud(width=800, height=400, background_color='white', font_path='simhei.ttf').generate(text_cut)

# 显示词云
plt.figure(figsize=(10, 5))
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')  # 隐藏坐标轴
plt.show()