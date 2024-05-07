#ifndef TASKLISTMODEL_H
#define TASKLISTMODEL_H

// #include "src/TaskListModel/task.h"
// #include <QAbstractListModel>

// class TaskListModel : public QAbstractListModel {
//     Q_OBJECT
// public:
//     enum Roles {
//         TaskName = Qt::UserRole + 1,
//         Description,
//         Completed
//     };

//     explicit TaskListModel();

// public slots:
//     void addTask(const QString &name, const QString &description);
//     void clearTasks();

//     // QAbstractItemModel interface
// public:
//     int rowCount(const QModelIndex &parent) const override;
//     QVariant data(const QModelIndex &index, int role) const override;
//     QHash<int, QByteArray> roleNames() const override;

// private:
//     QList<Task> m_tasks;
// };

#include "src/TaskListModel/task.h"
#include <QAbstractListModel>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

class TaskListModel : public QAbstractListModel {
    Q_OBJECT

public:
    enum Roles {
        UID = Qt::UserRole + 1,
        TaskName,
        Description,
        Completed
    };

    explicit TaskListModel(const QString& databaseName = "tasks.db");

public slots:
    void addTask(const QString &name, const QString &description);
    void clearTasks();
    bool openDatabase();
    bool closeDatabase();

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<Task> m_tasks;
    QString m_databaseName;
    QSqlDatabase m_database;

    // Helper functions for database operations
    bool createTableIfNotExists();
    bool saveTaskToDatabase(const Task& task);
    QList<Task> loadTasksFromDatabase();
};

#endif // TASKLISTMODEL_H
