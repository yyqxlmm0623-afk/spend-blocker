# Spend Blocker

一款帮助用户克制不必要消费、控制预算的 iOS MVP App。

## 目标

帮助用户在冲动消费前减速，建立更健康的消费习惯：
- 明确预算上限
- 在高额消费前设置冷静期
- 及时看到消费趋势与分类开销
- 更容易养成预算优先、消耗可控的生活方式

## 功能概览

### 已完成的 MVP 功能
- 每月预算设置
- 支出记账（分类、金额、日期、备注）
- 预算提醒与超支状态
- 购买冷静期：当金额超过阈值时，要求用户停留 10 秒再决定是否购买
- 每日/每周/每月基础统计
- 分类消费汇总与趋势显示

### 技术栈
- SwiftUI
- Foundation
- UserDefaults（本地存储）
- iOS 15+

## 项目结构

```text
SpendBlocker/
├── App/
│   └── SpendBlockerApp.swift
├── Models/
│   ├── Category.swift
│   ├── Budget.swift
│   └── Transaction.swift
├── Services/
│   └── StorageService.swift
├── ViewModels/
│   └── ExpenseStore.swift
├── Views/
│   ├── ContentView.swift
│   ├── HomeView.swift
│   ├── AddTransactionView.swift
│   ├── CalmPeriodView.swift
│   ├── StatisticsView.swift
│   └── SettingsView.swift
├── README.md
└── docs/
    └── PRD.md
```

## 运行方式

1. 打开 Xcode
2. 创建一个 iOS App 项目
3. 将 `SpendBlocker/` 下的文件导入到项目中
4. 选择 iPhone Simulator 运行

## MVP 使用说明

### 1. 设置预算
进入“设置”页，配置月度预算、冷静期金额阈值和冷静期时长。

### 2. 添加消费
在首页点击“记一笔”，填写分类、金额、说明和日期。

### 3. 触发冷静期
如果消费金额大于或等于阈值，应用会弹出 10 秒冷静期界面，要求用户确认是否继续购买。

### 4. 查看统计
在“统计”标签页中看到分类支出和月度趋势。

## 下一步扩展方向
- Apple Health 接入
- 预算目标与储蓄目标
- 交易重复记录/模板
- 通知提醒
- Siri/快捷指令支持
- 云同步

## 相关文档
- `docs/PRD.md`：产品需求文档
