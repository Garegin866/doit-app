#include "tasklistmodel.h"

// TaskListModel::TaskListModel() {}

// void TaskListModel::addTask(const QString &name, const QString &description) {
//     beginInsertRows(QModelIndex(), m_tasks.size(), m_tasks.size());
//     m_tasks.append(Task(name, description));
//     endInsertRows();
// }


// void TaskListModel::clearTasks() {
//     beginRemoveRows(QModelIndex(), 0, m_tasks.size());
//     m_tasks.clear();
//     endRemoveRows();
// }

// int TaskListModel::rowCount(const QModelIndex &parent) const {
//     Q_UNUSED(parent);
//     return m_tasks.size();
// }

// QVariant TaskListModel::data(const QModelIndex &index, int role) const {
//     if (!index.isValid()) {
//         return QVariant();
//     }

//     if (index.row() >= m_tasks.size()) {
//         return QVariant();
//     }

//     const Task &task = m_tasks.at(index.row());
//     if (role == TaskName) {
//         return task.name();
//     } else if (role == Description) {
//         return task.description();
//     } else if (role == Completed) {
//         return task.checked();
//     }

//     return QVariant();
// }

// QHash<int, QByteArray> TaskListModel::roleNames() const {
//     QHash<int, QByteArray> roles;
//     roles[TaskName] = "taskName";
//     roles[Description] = "description";
//     roles[Completed] = "completed";
//     return roles;
// }

TaskListModel::TaskListModel(const QString& databaseName) : m_databaseName(databaseName) {}

bool TaskListModel::openDatabase() {
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName(m_databaseName);
    if (!m_database.open()) {
        qWarning() << "Failed to open database:" << m_database.lastError().text();
        return false;
    }
    return createTableIfNotExists();
}

bool TaskListModel::closeDatabase() {
    if (m_database.isOpen()) {
        m_database.close();
    }
    return true;
}

bool TaskListModel::createTableIfNotExists() {
    QSqlQuery query(m_database);
    query.exec("CREATE TABLE IF NOT EXISTS tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, description TEXT, completed BOOLEAN)");
    return !query.lastError().isValid();
}

bool TaskListModel::saveTaskToDatabase(const Task& task) {
    QSqlQuery query(m_database);
    query.prepare("INSERT INTO tasks (name, description, completed) VALUES (:name, :description, :completed)");
    query.bindValue(":name", task.name());
    query.bindValue(":description", task.description());
    query.bindValue(":completed", task.completed());
    return query.exec();
}

QList<Task> TaskListModel::loadTasksFromDatabase() {
    QList<Task> tasks;
    QSqlQuery query(m_database);
    query.exec("SELECT name, description, completed FROM tasks");
    while (query.next()) {
        QString name = query.value("name").toString();
        QString description = query.value("description").toString();
        bool completed = query.value("completed").toBool();
        tasks.append(Task(name, description, completed));
    }
    return tasks;
}

void TaskListModel::addTask(const QString &name, const QString &description) {
    // Add task to internal list
    beginInsertRows(QModelIndex(), m_tasks.size(), m_tasks.size());
    m_tasks.append(Task(name, description));
    endInsertRows();

    // Save task to database (if database is open)
    if (m_database.isOpen()) {
        saveTaskToDatabase(m_tasks.last());
    }
}

void TaskListModel::clearTasks() {
    // Clear internal list
    beginRemoveRows(QModelIndex(), 0, m_tasks.size());
    m_tasks.clear();
    endRemoveRows();

    // Clear tasks from database (if database is open)
    if (m_database.isOpen()) {
        QSqlQuery query(m_database);
        query.exec("DELETE FROM tasks");
    }
}


int TaskListModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent);
    return m_tasks.size();
}

QVariant TaskListModel::data(const QModelIndex &index, int role) const {
    // ... Same logic as before for retrieving data from internal list ...
}

QHash<int, QByteArray> TaskListModel::roleNames() const {
    // ... Same logic as before for defining roles ...
}
