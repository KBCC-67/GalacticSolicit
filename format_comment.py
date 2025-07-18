
input_file_path = '完整评语.csv'    # 替换为实际输入文件路径
output_file_path = 'output.csv'  # 替换为实际输出文件路径
try:
    with open(input_file_path, 'r', encoding='utf-8') as infile:
        lines = infile.readlines()

    processed_lines = []
    for line in lines:
        stripped_line = line.rstrip('\n')
        
        # 移除行末连续的逗号
        stripped_line = stripped_line.rstrip(',')
        
        # 处理行内的逗号
        parts = stripped_line.split(',')
        processed_parts = []
        comment_count = -1
        
        for part in parts:
            #if part == ',':
            comment_count += 1
            if comment_count>=1:
                processed_parts.append(f'/*评审意见{comment_count}*/：')
            processed_parts.append(part)
            #else:
            #    processed_parts.append(part)
        
        processed_line = ' '.join(processed_parts)
        processed_lines.append(processed_line)

    with open(output_file_path, 'w', encoding='utf-8') as outfile:
        outfile.write('\n'.join(processed_lines))

    print(f"处理完成！结果已保存至 {output_file_path}")

except FileNotFoundError:
    print(f"错误：找不到输入文件 {input_file_path}")
except Exception as e:
    print(f"发生错误：{e}")