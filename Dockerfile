# CLO835 - the container way.
# Every line below repeats one manual step from the EC2 lab (Week02).
#
# Ubuntu 26.04 LTS "Resolute Raccoon" ships Python 3.14.
FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# Manual step: sudo apt-get install -y python3 python3-venv
RUN apt-get update -y \
 && apt-get install -y --no-install-recommends python3 python3-venv ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# Manual step: python3 -m venv venv && source venv/bin/activate
# Ubuntu 24.04 and later protect the system Python (PEP 668), so
# "pip3 install flask" fails. A virtual environment is the correct answer.
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Manual step: pip install -r requirements.txt
# requirements.txt is copied first, so Docker reuses this layer when only
# app.py changes.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

# Manual step: python3 app.py
ENV PORT=18080
EXPOSE 18080
CMD ["python3", "app.py"]
