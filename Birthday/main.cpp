#include <QGuiApplication>
#include <QQmlEngine>
#include <QQuickView>
#include <QtQml>
#include <QApplication>
#include <QtQuick>
#include <QScreen>

//STD
#include <memory>
#include <functional>
#include <type_traits>

template<typename Ty>
using Deleter = std::function<void(Ty*)>;

class Dlt{
public:
    Dlt()=default;
    Dlt(const Dlt& other)=default;
    Dlt& operator=(const Dlt& other)=default;

    template<typename Ty,
             typename = typename std::enable_if<std::is_pointer<Ty>::value, void>::type>
    void operator()(Ty ptr)noexcept
    {
        if(ptr != nullptr){
            delete ptr;
        }
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    //QApplication app(argc, argv);



    /*
    int virtualWidth = 0;
    int virtualHeight = 0;
    int trueWidth = 0;
    int trueHeight = 0;
    int screenWidth = 0;
    int screenHeight = 0;
    */

    int availableWidth = 0;
    int availableHeight = 0;

    QScreen* screen = QGuiApplication::primaryScreen();

    if(screen != nullptr){
        QSize availableWH = screen->availableSize();

        availableWidth = availableWH.width();
        availableHeight = availableWH.height();

        qDebug() << availableWH;
    }

    /*
    QDesktopWidget* desktopWidget = QApplication::desktop();

    if(desktopWidget){
        virtualWidth = desktopWidget->width();
        virtualHeight = desktopWidget->height();
        std::cout<< virtualWidth << "--------------" << virtualHeight << std::endl;

        QRect trueRect = desktopWidget->availableGeometry();
        trueWidth = trueRect.width();
        trueHeight = trueRect.height();
        std::cout << trueWidth << "----------------" << trueHeight << std::endl;

        QRect screenRect = desktopWidget->screenGeometry();
        screenWidth = screenRect.width();
        screenHeight = screenRect.height();
        std::cout << screenWidth << "----------------" << screenHeight << std::endl;
    }
    */



    /*
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("DeviceWidth", availableWidth);
    engine.rootContext()->setContextProperty("DeviceHeight", availableHeight);
    */



    std::unique_ptr<QQmlEngine,
                    Deleter<QQmlEngine>> engine{new QQmlEngine,
                    Dlt()};

    std::unique_ptr<QQuickView,
                    Deleter<QQuickView>> view{new QQuickView{engine.get(), nullptr},
                    Dlt()};

    engine->rootContext()->setContextProperty("DeviceWidth", availableWidth);
    engine->rootContext()->setContextProperty("DeviceHeight", availableHeight);
    view->setSource(QUrl(QStringLiteral("qrc:///main.qml")));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();


 //   QQuickView view;
 //   view.setSource(QUrl(QStringLiteral("qrc:///main.qml")));
 //   view.show();


    return app.exec();
}
