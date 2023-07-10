resource "yandex_compute_disk" "storage" {
  count    = 3
  name     = "disk-${count.index+1}"
  type     = "network-hdd"
  size     = 1
  zone     = var.default_zone
}

resource "yandex_compute_instance" "disk_machine" {
  count=1
  name        = "storage"
  platform_id = "standard-v1"
  resources {
    cores         = 2
    memory        = 4 
    core_fraction = 5
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

   dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage
    content {
     disk_id = secondary_disk.value.id
    }
   }

  metadata = {
    ssh-keys           = local.file
  }
}

  