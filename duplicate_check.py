import jieba
import re
from itertools import islice

def load_stopwords():
    """加载中文停用词表"""
    return {
        '的', '了', '在', '是', '我', '有', '和', '就', '不', '人', '都', '一个', '要', '与', '等', '说',
        '会', '没有', '这', '中', '对', '你', '我们', '好', '他', '也', '而', '并', '但', '从', '以', '又',
        '年', '月', '日', '上', '下', '时', '分', '秒', '这', '那', '哪', '为', '被', '让', '到', '去'
    }

def process_text(file_path, ngram=3):
    """处理文本：分词、去停用词、生成ngram"""
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 去除非中文字符和标点
    content = re.sub(r'[^\u4e00-\u9fa5]', '', content)
    
    # 结巴分词
    words = list(jieba.cut(content))
    
    # 去除停用词
    stopwords = load_stopwords()
    words = [w for w in words if w not in stopwords and len(w) > 1]
    
    # 生成ngram
    ngrams = []
    for i in range(len(words)-ngram+1):
        ngrams.append("".join(words[i:i+ngram]))
    
    return set(ngrams)

def calculate_similarity(set_a, set_b):
    """计算双向相似度"""
    a_in_b = len(set_a & set_b) / len(set_a) if len(set_a) > 0 else 0
    b_in_a = len(set_b & set_a) / len(set_b) if len(set_b) > 0 else 0
    return a_in_b, b_in_a

# 文件路径
a_path = "aaa.txt"
b_path = "bbb.txt"

# 处理文本（可调整ngram参数）
a_ngrams = process_text(a_path, ngram=3)
b_ngrams = process_text(b_path, ngram=3)

# 计算相似度
a_in_b_rate, b_in_a_rate = calculate_similarity(a_ngrams, b_ngrams)

print(f"【论文级查重结果】")
print(f"投稿在公众号中的语义重复率：{a_in_b_rate:.2%}")
print(f"公众号在投稿中的语义重复率：{b_in_a_rate:.2%}")
print("\n检测原理：")
print("- 使用3-gram滑动窗口比对语义片段")
print("- 过滤停用词和标点符号")
print("- 基于分词后的语义单元计算重复比例")