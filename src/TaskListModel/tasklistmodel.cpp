#include "tasklistmodel.h"

TaskListModel::TaskListModel() {
    if (!connectToDatabase()) {
        qWarning() << "Failed to connect to database";
        return; // Handle connection error
    }

    if (!createTasksTable()) {
        qWarning() << "Failed to create tasks table";
        return; // Handle table creation error
    }

    loadTasks();
}

void TaskListModel::addTask(const QString &name, const QString &description) {
    QSqlQuery query(QSqlDatabase::database());
    query.prepare("INSERT INTO tasks (name, description, completed) VALUES (:name, :description, :completed)");
    query.bindValue(":name", name);
    query.bindValue(":description", description);
    query.bindValue(":completed", false);
    query.exec();
    if (query.lastError().isValid()) {
        qWarning() << "Failed to add task:" << query.lastError().text();
    }

    int uid = query.lastInsertId().toInt();
    beginInsertRows(QModelIndex(), m_tasks.size(), m_tasks.size());
    m_tasks.append(Task(uid, name, description));
    endInsertRows();
}

void TaskListModel::setTaskCompleted(int index, bool completed) {
    auto &task = m_tasks[index];
    task.setCompleted(completed);

    QSqlQuery query(QSqlDatabase::database());
    query.prepare("UPDATE tasks SET completed = :completed WHERE uid = :uid");
    query.bindValue(":completed", completed);
    query.bindValue(":uid", task.uid());
    query.exec();
    if (query.lastError().isValid()) {
        qWarning() << "Failed to update task:" << query.lastError().text();
    }

    emit dataChanged(this->index(index), this->index(index));
}

void TaskListModel::removeTask(int index) {
    beginRemoveRows(QModelIndex(), index, index);
    auto task = m_tasks.takeAt(index);
    endRemoveRows();

    QSqlQuery query(QSqlDatabase::database());
    query.prepare("DELETE FROM tasks WHERE uid = :uid");
    query.bindValue(":uid", task.uid());
    query.exec();
    if (query.lastError().isValid()) {
        qWarning() << "Failed to remove task:" << query.lastError().text();
    } else {
        qInfo() << "Removed task at index" << task.uid();
    }
}


void TaskListModel::clearTasks() {
    beginRemoveRows(QModelIndex(), 0, m_tasks.size());
    m_tasks.clear();
    endRemoveRows();

    QSqlQuery query(QSqlDatabase::database());
    query.exec("DELETE FROM tasks");
    if (query.lastError().isValid()) {
        qWarning() << "Failed to clear tasks:" << query.lastError().text();
    }
}

int TaskListModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_tasks.size();
}

QVariant TaskListModel::data(const QModelIndex &index, int role) const {
    if (!index.isValid()) {
        return QVariant();
    }

    if (index.row() >= m_tasks.size()) {
        return QVariant();
    }

    const Task &task = m_tasks.at(index.row());
    if (role == TaskName) {
        return task.name();
    } else if (role == Description) {
        return task.description();
    } else if (role == Completed) {
        return task.completed();
    }

    return QVariant();
}

QHash<int, QByteArray> TaskListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[TaskName] = "taskName";
    roles[Description] = "description";
    roles[Completed] = "completed";
    return roles;
}

void TaskListModel::loadTasks() {
    if (!connectToDatabase()) {
        qWarning() << "Failed to connect to database";
        return; // Handle connection error
    }

    QSqlQuery query(QSqlDatabase::database());
    query.exec("SELECT * FROM tasks");

    if (query.lastError().isValid()) {
        qWarning() << "Failed to load tasks:" << query.lastError().text();
        return;
    }

    beginInsertRows(QModelIndex(), m_tasks.size(), m_tasks.size());
    while (query.next()) {
        int uid = query.value("uid").toInt();
        QString name = query.value("name").toString();
        QString description = query.value("description").toString();
        bool completed = query.value("completed").toBool();
        m_tasks.append(Task(uid, name, description, completed));
    }
    endInsertRows();
}

bool TaskListModel::connectToDatabase() {
    if (QSqlDatabase::database().isValid()) {
        return true;
    }
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("tasks.db"); // Adjust filename as needed

    if (!db.open()) {
        qWarning() << "Failed to connect to database:" << db.lastError().text();
        return false;
    }

    qInfo() << "Connected to database" << db.databaseName();
    return true;
}

bool TaskListModel::createTasksTable() {
    if (!QSqlDatabase::database().isOpen()) {
        qWarning() << "Database is not open";
        return false;
    }

    // check if table already exists
    QSqlQuery checkQuery(QSqlDatabase::database());
    checkQuery.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='tasks'");
    checkQuery.exec();
    if (checkQuery.next()) {
        qInfo() << "Table already exists";
        return true;
    }

    QSqlQuery query(QSqlDatabase::database());
    query.exec("CREATE TABLE IF NOT EXISTS tasks ("
               "uid INTEGER PRIMARY KEY AUTOINCREMENT, "
               "name TEXT, "
               "description TEXT, "
               "completed BOOLEAN)");

    if (query.lastError().isValid()) {
        qWarning() << "Failed to create tasks table:" << query.lastError().text();
        return false;
    }

    return true;
}
