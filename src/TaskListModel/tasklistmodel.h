#ifndef TASKLISTMODEL_H
#define TASKLISTMODEL_H

#include "src/TaskListModel/task.h"
#include <QAbstractListModel>

#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

class TaskListModel : public QAbstractListModel {
    Q_OBJECT
public:
    enum Roles {
        TaskName = Qt::UserRole + 1,
        Description,
        Completed
    };

    explicit TaskListModel();

public slots:
    void addTask(const QString &name, const QString &description);
    void setTaskCompleted(int index, bool completed);
    void removeTask(int index);
    void clearTasks();

    // QAbstractItemModel interface
public:
    int rowCount(const QModelIndex &parent) const override;
    QVariant data(const QModelIndex &index, int role) const override;
    QHash<int, QByteArray> roleNames() const override;

private:
    QList<Task> m_tasks;

private:
    void loadTasks();

    bool connectToDatabase();
    bool createTasksTable();
};
#endif // TASKLISTMODEL_H
