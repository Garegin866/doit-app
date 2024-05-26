#include "task.h"

Task::Task(int uuid, const QString &name, const QString &description, bool completed)
    : m_uid(uuid), m_taskName(name), m_description(description), m_completed(completed) {

}

QString Task::name() const {
    return m_taskName;
}

void Task::setName(const QString &name) {
    m_taskName = name;
}

QString Task::description() const {
    return m_description;
}

void Task::setDescription(const QString &description) {
    m_description = description;
}

bool Task::completed() const {
    return m_completed;
}

void Task::setCompleted(bool completed) {
    m_completed = completed;
}

int Task::uid() const {
    return m_uid;
}

void Task::setUid(int uid) {
    m_uid = uid;
}
