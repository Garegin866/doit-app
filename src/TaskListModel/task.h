#ifndef TASK_H
#define TASK_H

#include <QString>

class Task {
public:
    Task(const QString &name, const QString &description, bool completed = false);

    QString name() const;
    void setName(const QString &name);

    QString description() const;
    void setDescription(const QString &description);

    bool completed() const;
    void setCompleted(bool completed);

    int uid() const;
    void setUid(int uid);

private:
    int m_uid;
    QString m_taskName;
    QString m_description;
    bool m_completed;
};

#endif // TASK_H
