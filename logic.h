#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>

class logic : public QObject
{
    Q_OBJECT
public:
    explicit logic(QObject *parent = nullptr);

signals:

public slots:

private:
    QVector<int> integerVector;
};

#endif // LOGIC_H
