% 读取以空格分隔的score.csv文件 %%这个是真的所有人的打分构成的csv，然后代码进行归一化。。？
filename = '全部评分（用于画箱型图）.csv';
fid = fopen(filename, 'r');
 
% 初始化存储变量
data = cell(0, 2); % 第一列存作品名称，第二列存评分数组
 
% 逐行读取文件
while ~feof(fid)
    line = fgetl(fid); % 读取一行
    if isempty(line) || line(1) == '#' % 跳过空行和注释行
        continue;
    end
    
    % 分割行内容（按空格分割）
    parts = strsplit(line, '	');
    
    % 第一个元素是作品名称
    work_name = parts{1};
    
    % 剩余部分是评分（转换为数值）
    % 注意：需要过滤掉可能存在的空字符串（如多个连续空格的情况）
    scores = parts(2:end);
    scores = scores(~cellfun('isempty', scores)); % 移除空单元格
    scores = str2double(scores); % 转换为数值
    
    % 存储到data cell数组中
    data{end+1, 1} = work_name;
    data{end, 2} = scores;
end
 
fclose(fid);
 
% 将数据转换为更易用的结构体数组
works = cell(size(data, 1), 1);
scores_cell = cell(size(data, 1), 1);
for i = 1:size(data, 1)
    works{i} = data{i, 1};
    scores_cell{i} = data{i, 2};
end
%% 接下来逐一对齐数据画箱型图
data=cell2mat(scores_cell(1));
labels=ones(size(cell2mat(scores_cell(1))));
for i=2:size(works,1)
    data=[data,cell2mat(scores_cell(i))];
    labels=[labels,i*ones(size(cell2mat(scores_cell(i))))];
end
for j_idx=1:5
    st=(j_idx-1)*13+1;
    ed=(j_idx)*13;
    if ed>=52
        ed=52;
    end
    idxes= find(labels>=st & labels<=ed);
    tmp_data=data(idxes);
    tmp_label=labels(idxes);
    tmp_works=works(st:ed);
    figure;
    boxplot(tmp_data,tmp_label, 'Labels', tmp_works);
end