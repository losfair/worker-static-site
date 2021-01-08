import mime from "mime-types";

addEventListener("fetch", event => {
    event.respondWith(handleRequest(event.request));
});

/**
 * 
 * @param {Request} request
 */
async function handleRequest(request) {
    let url = new URL(request.url);
    let filePath;

    if(url.pathname.endsWith("/")) {
        filePath = url.pathname + "index.html";
    } else {
        filePath = url.pathname;
    }
    let file = getFileFromBundle("./res" + filePath);
    if(file === null) {
        return new Response("not found", {
            status: 404,
        });
    } else {
        let contentType = mime.lookup(filePath) || "application/octet-stream";
        return new Response(file, {
            headers: {
                "Content-Type": contentType,
            }
        });
    }
}
